#!/usr/bin/env bash

# --- OpenCode --- #
if command -v opencode &>/dev/null; then
  cache-completion opencode opencode --completions zsh
fi
