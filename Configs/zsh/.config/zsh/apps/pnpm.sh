#!/usr/bin/env bash

# ---- pnpm ---- #
export PNPM_HOME="${PNPM_HOME:-${XDG_DATA_HOME}/pnpm}"

case ":${PATH}:" in
*":${PNPM_HOME}/bin:"*) ;; # Pass
*) export PATH="${PNPM_HOME}/bin:${PATH}" ;;
esac
