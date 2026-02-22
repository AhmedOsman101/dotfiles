#!/usr/bin/env bash

# --- OpenCode --- #
if command -v opencode &>/dev/null; then
  eval "$(opencode completion zsh)"
fi
