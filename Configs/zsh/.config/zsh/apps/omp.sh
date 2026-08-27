#!/usr/bin/env bash

# --- Oh-My-Pi --- #
if command -v omp &>/dev/null; then
  eval "$(omp completions zsh)"
fi
