#!/usr/bin/env zsh

# --- Zshrc concurrency guard --- #
# Serializes parallel .zshrc sourcing (tmux-resurrect + continuum restores N panes at once).
# Without this, N shells race on compinit / zinit / file writes and thrash the machine.
#
# Strategy: flock (advisory, per-fd, auto-released on close) > zsystem flock > mkdir spin.
# - Lock is held ONLY during .zshrc sourcing (~0.5-2s per shell), not for the shell lifetime.
# - Blocking with timeout (default 60s). Workers queue FIFO-ish via kernel wait queue.
# - Stale-safe: flock is kernel-tracked; no manual cleanup needed. Mkdir fallback has TTL.
#
# Usage in .zshrc:
#   [[ -o interactive ]] || return
#   source "${ZDOTDIR}/lock.sh"   # auto-acquires
#   # ... modules, plugins, apps ...
#   _zshrc_lock_release           # at the very end, before tmux autostart
#
# Env overrides:
#   ZSHRC_LOCK_TIMEOUT=60          # seconds to wait before giving up (0 = infinite)
#   ZSHRC_LOCK_FILE=...            # custom lock path
#   ZSHRC_LOCK_DEBUG=1             # verbose

# Only for Zsh (sourcing from bash during tests is a no-op)
if [[ -z "${ZSH_VERSION:-}" ]]; then
  return 0 2>/dev/null || exit 0
fi

# --- Config (idempotent: preserve existing state on re-source) ---
if [[ -z "${__ZSHRC_LOCK_FILE+x}" ]]; then
  typeset -g __ZSHRC_LOCK_FILE="${ZSHRC_LOCK_FILE:-${XDG_CACHE_HOME:-${HOME}/.cache}/zsh/.zshrc.lock}"
fi
if [[ -z "${__ZSHRC_LOCK_TIMEOUT+x}" ]]; then
  typeset -g __ZSHRC_LOCK_TIMEOUT="${ZSHRC_LOCK_TIMEOUT:-60}"
fi
if [[ -z "${__ZSHRC_LOCK_DEBUG+x}" ]]; then
  typeset -g __ZSHRC_LOCK_DEBUG="${ZSHRC_LOCK_DEBUG:-0}"
fi

# Internal state (preserve across re-source; init only once)
if [[ -z "${__ZSHRC_LOCK_FD+x}" ]]; then
  typeset -g __ZSHRC_LOCK_FD
fi
if [[ -z "${__ZSHRC_LOCK_MODE+x}" ]]; then
  typeset -g __ZSHRC_LOCK_MODE
fi
if [[ -z "${__ZSHRC_LOCK_HELD+x}" ]]; then
  typeset -g __ZSHRC_LOCK_HELD=0
fi
if [[ -z "${__ZSHRC_LOCK_DIR+x}" ]]; then
  typeset -g __ZSHRC_LOCK_DIR
fi

# Re-entrancy: if already held in this shell (e.g., `reload` -> source .zshrc again), no-op.
if (( __ZSHRC_LOCK_HELD )); then
  return 0
fi

_zshrc_lock_acquire() {
  local lock_file="${__ZSHRC_LOCK_FILE}"
  local timeout="${__ZSHRC_LOCK_TIMEOUT}"
  local debug="${__ZSHRC_LOCK_DEBUG}"
  local start now elapsed

  # Ensure parent dir exists
  mkdir -p "${lock_file:h}" 2>/dev/null || mkdir -p "${HOME}/.cache/zsh" 2>/dev/null
  # Ensure file exists (zsystem flock requires it); skip when already there
  [[ -f "${lock_file}" ]] || : > "${lock_file}" 2>/dev/null || true

  # ---- 1) Try external flock (util-linux) — preferred, most robust ----
  if command -v flock &>/dev/null; then
    # Open FD (zsh `exec {var}>file` allocates a free FD)
    exec {__ZSHRC_LOCK_FD}> "${lock_file}" 2>/dev/null
    if [[ -n "${__ZSHRC_LOCK_FD:-}" ]]; then
      # Fast path: uncontended start (the common case) → instant acquire, no wait syscall
      if flock -n "${__ZSHRC_LOCK_FD}" 2>/dev/null; then
        __ZSHRC_LOCK_MODE="flock"
        __ZSHRC_LOCK_HELD=1
        (( debug )) && print -P "%F{green}[zshrc-lock]%f acquired (flock -n, fd ${__ZSHRC_LOCK_FD})" >&2
        return 0
      fi
      # Contended (tmux restore herd) → block with timeout
      (( debug )) && print -P "%F{yellow}[zshrc-lock]%f contended; waiting for flock (timeout ${timeout}s) on ${lock_file} (fd ${__ZSHRC_LOCK_FD})" >&2
      if [[ "${timeout}" == "0" ]]; then
        flock "${__ZSHRC_LOCK_FD}" 2>/dev/null
      else
        flock -w "${timeout}" "${__ZSHRC_LOCK_FD}" 2>/dev/null
      fi
      local rc=$?
      if (( rc == 0 )); then
        __ZSHRC_LOCK_MODE="flock"
        __ZSHRC_LOCK_HELD=1
        (( debug )) && print -P "%F{green}[zshrc-lock]%f acquired (flock, fd ${__ZSHRC_LOCK_FD})" >&2
        return 0
      else
        (( debug )) && print -P "%F{red}[zshrc-lock]%f flock timeout/fail (rc=${rc}), falling back" >&2
        # Close the FD we opened (failed to lock) before trying next method
        exec {__ZSHRC_LOCK_FD}>&- 2>/dev/null
        unset __ZSHRC_LOCK_FD
      fi
    fi
  fi

  # ---- 2) Try zsh/system flock (fcntl, built-in) ----
  if zmodload zsh/system 2>/dev/null; then
    # zsystem flock needs the file to exist (ensured above) and will open its own FD via -f
    (( debug )) && print -P "%F{yellow}[zshrc-lock]%f waiting for zsystem flock (timeout ${timeout}s) on ${lock_file}" >&2
    local zfd
    if [[ "${timeout}" == "0" ]]; then
      zsystem flock -f zfd "${lock_file}" 2>/dev/null
    else
      zsystem flock -t "${timeout}" -f zfd "${lock_file}" 2>/dev/null
    fi
    local rc=$?
    if (( rc == 0 )); then
      __ZSHRC_LOCK_FD="${zfd}"
      __ZSHRC_LOCK_MODE="zsystem"
      __ZSHRC_LOCK_HELD=1
      (( debug )) && print -P "%F{green}[zshrc-lock]%f acquired (zsystem, fd ${__ZSHRC_LOCK_FD})" >&2
      return 0
    else
      (( debug )) && print -P "%F{red}[zshrc-lock]%f zsystem flock fail (rc=${rc}), falling back" >&2
      # zsystem may have left fd open on timeout==2; try to close if set
      if [[ -n "${zfd:-}" ]]; then
        zsystem flock -u "${zfd}" 2>/dev/null || exec {zfd}>&- 2>/dev/null || true
      fi
    fi
  fi

  # ---- 3) Fallback: mkdir spin lock (atomic, with TTL) ----
  # Use a directory as mutex; stale dirs older than 2*timeout are reaped.
  local lock_dir="${lock_file}.dir"
  __ZSHRC_LOCK_DIR="${lock_dir}"
  local ttl=$(( timeout == 0 ? 120 : timeout * 2 ))
  (( ttl < 30 )) && ttl=30
  start=${EPOCHSECONDS:-$(date +%s)}
  (( debug )) && print -P "%F{yellow}[zshrc-lock]%f waiting for mkdir lock on ${lock_dir} (ttl ${ttl}s)" >&2
  while true; do
    if mkdir "${lock_dir}" 2>/dev/null; then
      __ZSHRC_LOCK_MODE="mkdir"
      __ZSHRC_LOCK_HELD=1
      (( debug )) && print -P "%F{green}[zshrc-lock]%f acquired (mkdir ${lock_dir})" >&2
      return 0
    fi
    # Stale check: if dir mtime is older than ttl, reap it (crashed holder)
    if [[ -d "${lock_dir}" ]]; then
      local mtime
      mtime=$(stat -c %Y "${lock_dir}" 2>/dev/null || stat -f %m "${lock_dir}" 2>/dev/null || echo "${start}")
      now=${EPOCHSECONDS:-$(date +%s)}
      elapsed=$(( now - mtime ))
      if (( elapsed > ttl )); then
        (( debug )) && print -P "%F{red}[zshrc-lock]%f reaping stale mkdir lock (age ${elapsed}s > ${ttl}s)" >&2
        rm -rf "${lock_dir}" 2>/dev/null
        continue
      fi
      # Global timeout
      if [[ "${timeout}" != "0" ]]; then
        elapsed=$(( now - start ))
        if (( elapsed > timeout )); then
          print -P "%F{red}[zshrc-lock]%f timeout waiting for mkdir lock after ${elapsed}s — proceeding anyway (race risk)" >&2
          __ZSHRC_LOCK_MODE="none"
          return 1
        fi
      fi
    fi
    sleep 0.05
  done
}

_zshrc_lock_release() {
  local debug="${__ZSHRC_LOCK_DEBUG:-0}"
  if (( ! __ZSHRC_LOCK_HELD )); then
    return 0
  fi

  case "${__ZSHRC_LOCK_MODE}" in
    flock)
      (( debug )) && print -P "%F{green}[zshrc-lock]%f releasing flock (fd ${__ZSHRC_LOCK_FD})" >&2
      # flock is released automatically on FD close
      exec {__ZSHRC_LOCK_FD}>&- 2>/dev/null || true
      ;;
    zsystem)
      (( debug )) && print -P "%F{green}[zshrc-lock]%f releasing zsystem flock (fd ${__ZSHRC_LOCK_FD})" >&2
      zsystem flock -u "${__ZSHRC_LOCK_FD}" 2>/dev/null || exec {__ZSHRC_LOCK_FD}>&- 2>/dev/null || true
      ;;
    mkdir)
      (( debug )) && print -P "%F{green}[zshrc-lock]%f releasing mkdir lock (${__ZSHRC_LOCK_DIR})" >&2
      rmdir "${__ZSHRC_LOCK_DIR}" 2>/dev/null || rm -rf "${__ZSHRC_LOCK_DIR}" 2>/dev/null || true
      ;;
    *)
      ;;
  esac

  __ZSHRC_LOCK_HELD=0
  __ZSHRC_LOCK_MODE="none"
  unset __ZSHRC_LOCK_FD __ZSHRC_LOCK_DIR
  return 0
}

# --- Auto-acquire on source ---
# Guard against double-source in same shell (e.g., `reload`)
if (( ! __ZSHRC_LOCK_HELD )); then
  _zshrc_lock_acquire || true
fi

# Safety: if this shell exits while still holding the lock (e.g., `return`/`exit` mid-zshrc),
# release it. Use zshexit hook if available, else TRAPEXIT.
if (( __ZSHRC_LOCK_HELD )); then
  # Prefer add-zsh-hook if available (loaded later in plugins.sh, so may not exist yet).
  # Fall back to TRAPEXIT which zsh will call on shell exit.
  if (( $+functions[add-zsh-hook] )); then
    add-zsh-hook -Uz zshexit _zshrc_lock_release 2>/dev/null || true
  else
    # TRAPEXIT is a special function; defining it here will run on exit.
    # Wrap to avoid clobbering an existing TRAPEXIT.
    if (( ! $+functions[TRAPEXIT] )); then
      TRAPEXIT() { _zshrc_lock_release 2>/dev/null || true; }
    else
      # Chain: save old, wrap
      functions[_zshrc_lock_old_TRAPEXIT]="${functions[TRAPEXIT]}"
      TRAPEXIT() {
        _zshrc_lock_release 2>/dev/null || true
        _zshrc_lock_old_TRAPEXIT "$@"
      }
    fi
  fi
fi
