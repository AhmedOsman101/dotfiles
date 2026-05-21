#!/usr/bin/env bash

# ---- Atuin ---- #
if command -v delta &>/dev/null; then
  eval "$(delta --generate-completion zsh)"
fi
