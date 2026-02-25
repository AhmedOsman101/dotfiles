#!/usr/bin/env bash

# ---- Deno ---- #
[[ -s "${XDG_CACHE_HOME}/deno/env" ]] && source "${XDG_CACHE_HOME}/deno/env"
command -v deno &>/dev/null && eval "$(deno completions zsh --dynamic)"
