#!/usr/bin/env bash

# --- Delta --- #
if command -v delta &>/dev/null; then
  eval "$(delta --generate-completion zsh)"
fi
