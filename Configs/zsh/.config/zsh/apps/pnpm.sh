#!/usr/bin/env bash

# ---- pnpm ---- #
if command -v pnpm &>/dev/null; then
  export PATH="${PNPM_HOME}/bin:${PATH}"
fi
