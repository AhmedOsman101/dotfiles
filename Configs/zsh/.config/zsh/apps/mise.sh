#!/usr/bin/env bash

# --- Mise (runtime version manager) --- #
if command -v mise &>/dev/null; then
  eval "$(mise activate zsh)"
  mise completion zsh --install &>/dev/null
fi
