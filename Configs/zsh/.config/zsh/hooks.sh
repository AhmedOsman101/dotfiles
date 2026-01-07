#!/usr/bin/env bash

# ---- Rehash Zsh only when pacman updates /usr/bin ---- #
# Triggered by /usr/share/libalpm/hooks/archcraft-hook-zsh.hook
zshcache_time="$(date +%s%N)"

rehash_precmd() {
  local paccache_time
  if [[ -e /var/cache/zsh/pacman ]]; then
    paccache_time="$(date -r /var/cache/zsh/pacman +%s%N)"
    if ((zshcache_time < paccache_time)); then
      rehash
      zshcache_time="${paccache_time}"
    fi
  fi
}

# Handle python venv
python-hook() {
  if [[ -n "${VIRTUAL_ENV}" && "${PWD}" != *"${VIRTUAL_ENV:h}"* ]]; then
    deactivate
    return
  fi

  # If already in a virtualenv, do nothing
  [[ -n "${VIRTUAL_ENV}" ]] && return

  local dir="${PWD}"
  while [[ "${dir}" != "/" ]]; do
    if [[ -f "${dir}/.venv/bin/activate" ]]; then
      source "${dir}/.venv/bin/activate"
      return
    elif [[ -f "${dir}/venv/bin/activate" ]]; then
      source "${dir}/venv/bin/activate"
      return
    fi
    dir="${dir:h}"
  done
}

# Runs before any command
# precmd() { :; }
add-zsh-hook -Uz precmd rehash_precmd

# Runs when changing directories
# chpwd() { :; }
add-zsh-hook -Uz chpwd python-hook

# Runs after any command
# preexec() { :; }
