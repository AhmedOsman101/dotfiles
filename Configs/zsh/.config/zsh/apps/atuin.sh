#!/usr/bin/env bash

# ---- Atuin ---- #
if command -v atuin &>/dev/null; then
  [[ ":${PATH}:" != *":${HOME}/.atuin/bin:"* ]] && export PATH="${HOME}/.atuin/bin:${PATH}"
  [[ -s "${HOME}/.local/bin/atuin.sh" ]] && source "${HOME}/.local/bin/atuin.sh"
  eval "$(atuin gen-completions --shell zsh)"
fi
