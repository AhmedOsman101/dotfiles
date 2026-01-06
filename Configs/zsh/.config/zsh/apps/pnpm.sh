#!/usr/bin/env bash

# ---- pnpm ---- #
[[ ":${PATH}:" != *":${PNPM_HOME}:"* ]] && export PATH="${PNPM_HOME}:${PATH}"
