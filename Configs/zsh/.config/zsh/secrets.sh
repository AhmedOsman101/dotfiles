#!/usr/bin/env bash
# shellcheck disable=2034,2296

# --- Encrypted secrets cache --- #
# Per-shell `pass show` calls (one gpg-agent round-trip each, plus a pinentry
# storm when the agent is locked) used to dominate startup. Now: ONE `gpg -d`.
#
# - Cache: ${XDG_CACHE_HOME}/zsh/secrets.env.gpg, mode 600, encrypted to the same
#   GPG key as the password store (first line of ~/.password-store/.gpg-id).
# - At rest the file is ciphertext: opaque to casual reads (agents, grep, backups,
#   filesystem snapshots, offline disk). Plaintext only ever lives in shell memory —
#   populate pipes `pass` output straight into `gpg --encrypt`; no temp plaintext.
# - Populate runs only on cache miss, under the already-held global .zshrc lock,
#   so a startup herd converges on identical content (and any race is benign).
# - Rotation: `rm ${XDG_CACHE_HOME}/zsh/secrets.env.gpg`; the next shell repopulates.
# - Fail-closed populate (a partial set is never cached or exported), fail-open
#   shell (one warning, login proceeds).
#
# NOTE: only the 9 vars below gate anything. Add a name AND its pass line together.
#
# Threat-model note: while gpg-agent is unlocked, any same-uid process can ask it
# to decrypt. This stops accidental access, not targeted same-user extraction.

emulate -L zsh

_secrets_cache="${XDG_CACHE_HOME:-${HOME}/.cache}/zsh/secrets.env.gpg"

# ---- Fast path: decrypt the cache ---- #
# Agent-cached key = milliseconds, no prompt. Locked agent + tty = exactly one
# pinentry. No tty (benchmarks, pipes) = fast failure, shell continues secretless.
if [[ -s "${_secrets_cache}" ]]; then
  if (( $+commands[gpg] )); then
    _secrets_plain="$(gpg --batch --quiet -d -- "${_secrets_cache}" 2>/dev/null)"
    if [[ -n "${_secrets_plain}" ]]; then
      eval "${_secrets_plain}"
      unset _secrets_cache _secrets_plain
      return 0
    fi
  fi
  # Present but unreadable: warn once and stop. Do NOT fall through to pass —
  # that would hammer pinentry once per secret.
  print -r -- "secrets.sh: cannot decrypt ${_secrets_cache} (rm it to repopulate) — starting without secrets" >&2
  unset _secrets_cache _secrets_plain
  return 0
fi

# ---- Slow path: cache miss — resolve, verify, encrypt ---- #
if (( ! $+commands[pass] )) || (( ! $+commands[gpg] )); then
  print -r -- "secrets.sh: pass/gpg not available — starting without secrets" >&2
  unset _secrets_cache
  return 0
fi

read -r _secrets_rcpt < "${HOME}/.password-store/.gpg-id" 2>/dev/null
if [[ -z "${_secrets_rcpt:-}" ]]; then
  print -r -- "secrets.sh: no GPG recipient in ~/.password-store/.gpg-id — starting without secrets" >&2
  unset _secrets_cache _secrets_rcpt
  return 0
fi

_vars=(
  # ADVENT_OF_CODE_SESSION
  # AI_GATEWAY_API_KEY
  # ANILIST_TOKEN
  # CONTEXT7_API_KEY
  # FEATHERLESS_API_KEY
  # KIRO_PROXY_API_KEY
  # OBSIDIAN_API_KEY
  # OPENAI_API_KEY
  # ZAI_API_KEY
  ANTHROPIC_API_KEY
  EXA_API_KEY
  GEMINI_API_KEY
  GITHUB_TOKEN
  GOOGLE_GENERATIVE_AI_API_KEY
  HF_TOKEN
  NVIDIA_API_KEY
  OPENROUTER_API_KEY
  N9ROUTER_API_KEY
  OMNIROUTE_API_KEY
)

# ADVENT_OF_CODE_SESSION="$(pass show advent-of-code 2>/dev/null)"
# AI_GATEWAY_API_KEY="$(pass show vercel/ai-gateway 2>/dev/null)"
# ANILIST_TOKEN="$(pass show anilist/access-token 2>/dev/null)"
# CONTEXT7_API_KEY="$(pass show context7 2>/dev/null)"
# FEATHERLESS_API_KEY="$(pass show featherless 2>/dev/null | head -1)"
# KIRO_PROXY_API_KEY="$(pass show kiro 2>/dev/null)"
# OBSIDIAN_API_KEY="$(pass show obsidian/api-key 2>/dev/null)"
# OPENAI_API_KEY="$(pass show openai 2>/dev/null | head -1)"
# ZAI_API_KEY="$(pass show z.ai 2>/dev/null)"
EXA_API_KEY="$(pass show exa-search 2>/dev/null)"
GEMINI_API_KEY="$(pass show gemini 2>/dev/null)"
GITHUB_TOKEN="$(pass show github/tokens/main 2>/dev/null | head -1)"
GOOGLE_GENERATIVE_AI_API_KEY="${GEMINI_API_KEY}"
HF_TOKEN="$(pass show hugging-face 2>/dev/null)"
NVIDIA_API_KEY="$(pass show nvidia/api-key 2>/dev/null)"
OPENROUTER_API_KEY="$(pass show openrouter 2>/dev/null)"
N9ROUTER_API_KEY="$(pass show 9router 2>/dev/null)"
OMNIROUTE_API_KEY="$(pass show omniroute 2>/dev/null)"
ANTHROPIC_API_KEY="${OMNIROUTE_API_KEY}"

# Fail closed: every live var must resolve, or nothing is cached or exported.
# Assembly happens in the same pass (quoting round-trips through eval below).
_secrets_ok=true
_secrets_plain=""
for _v in "${_vars[@]}"; do
  if [[ -z "${(P)_v}" ]]; then
    _secrets_ok=false
    break
  fi
  _secrets_plain+="export ${_v}=${(q)${(P)_v}}"$'\n'
done

if ${_secrets_ok}; then
  # Encrypt from memory straight into a 0600 tmp file, then move into place.
  [[ -d "${_secrets_cache:h}" ]] || mkdir -p "${_secrets_cache:h}" 2>/dev/null
  _secrets_tmp="${_secrets_cache}.$$"
  : >| "${_secrets_tmp}" 2>/dev/null && chmod 600 "${_secrets_tmp}" 2>/dev/null
  if print -r -- "${_secrets_plain}" | gpg --batch --quiet --trust-model always --encrypt --recipient "${_secrets_rcpt}" -o "${_secrets_tmp}" 2>/dev/null \
      && [[ -s "${_secrets_tmp}" ]]; then
    mv -f "${_secrets_tmp}" "${_secrets_cache}" 2>/dev/null
    chmod 600 "${_secrets_cache}" 2>/dev/null
  else
    rm -f "${_secrets_tmp}" 2>/dev/null
  fi
  export "${_vars[@]}"
else
  print -r -- "secrets.sh: failed to resolve all secrets — starting without them" >&2
  unset "${_vars[@]}"
fi

unset _secrets_cache _secrets_plain _secrets_tmp _secrets_rcpt _secrets_ok _v _vars
