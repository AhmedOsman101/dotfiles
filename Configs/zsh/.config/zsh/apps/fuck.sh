#!/usr/bin/env bash

# --- Fuck --- #
if command -v thefuck &>/dev/null; then
  eval "$(thefuck --alias)"
fi
