#!/usr/bin/env bash

# --- Zoxide --- #
if command -v zoxide &>/dev/null; then
  eval "$(zoxide init zsh)"
  alias cd="z"
fi
