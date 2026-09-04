#!/usr/bin/env bash

# --- Bun --- #
if command -v bun &>/dev/null; then
  cache-completion bun bun completions
  [[ -s "${BUN_INSTALL}/_bun" ]] && source "${BUN_INSTALL}/_bun"
fi
