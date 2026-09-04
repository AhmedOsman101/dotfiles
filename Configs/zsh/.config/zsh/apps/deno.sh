#!/usr/bin/env bash

# --- Deno --- #
[[ -s "${XDG_CACHE_HOME}/deno/env" ]] && source "${XDG_CACHE_HOME}/deno/env"
command -v deno &>/dev/null && cache-completion deno deno completions zsh --dynamic
