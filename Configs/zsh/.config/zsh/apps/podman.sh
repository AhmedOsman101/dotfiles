#!/usr/bin/env bash

# --- Podman --- #
command -v podman &>/dev/null && podman completion zsh 2>/dev/null >"${ZSH_CACHE_DIR}/completions/_podman"
