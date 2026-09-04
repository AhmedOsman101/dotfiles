#!/usr/bin/env bash

# --- uv / uvx --- #
if command -v uv &>/dev/null; then
  cache-completion uv uv generate-shell-completion zsh
  command -v uvx &>/dev/null && cache-completion uvx uvx --generate-shell-completion zsh
fi
