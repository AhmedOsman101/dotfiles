#!/usr/bin/env bash

# --- Podman --- #
# NOTE: cache-completion sources cached file directly, so _podman lives in cache dir (not FPATH)
command -v podman &>/dev/null && cache-completion _podman podman completion zsh
