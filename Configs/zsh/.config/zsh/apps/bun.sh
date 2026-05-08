#!/usr/bin/env bash

# --- Bun --- #
if command -v bun &>/dev/null; then
  bun completions &>/dev/null
  [[ -s "${BUN_INSTALL}/_bun" ]] && source "${BUN_INSTALL}/_bun"
fi
