#!/usr/bin/env bash

# --- Mise (runtime version manager) --- #
if command -v mise &>/dev/null; then
  eval "$(mise activate zsh)"
  cache-completion mise mise completion zsh
  # bash completions are for real bash sessions only (bash-completion package
  # lookup dir) — never sourced into zsh, where `complete -F` is meaningless.
  _mise_bash="${XDG_DATA_HOME}/bash-completion/completions/mise"
  if [[ ! -s "${_mise_bash}" ]] || [[ "${commands[mise]}" -nt "${_mise_bash}" ]]; then
    mkdir -p "${_mise_bash:h}"
    mise completion bash --include-bash-completion-lib >|"${_mise_bash}" 2>/dev/null
    [[ -s "${_mise_bash}" ]] || rm -f "${_mise_bash}" # don't keep a broken/empty file
  fi
  unset _mise_bash
fi
