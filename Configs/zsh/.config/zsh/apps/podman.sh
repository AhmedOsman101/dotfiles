#!/usr/bin/env bash

# --- Podman --- #
# NOTE: cache-completion sources cached file directly, so _podman lives in cache dir (not FPATH)
command -v podman &>/dev/null && cache-completion _podman podman completion zsh
# Belt-and-braces: a sourced #compdef-style file defines _podman but only binds it
# if it self-registers. Binding an already-bound name is a harmless no-op.
(( $+functions[_podman] )) && (( $+functions[compdef] )) && compdef _podman podman 2>/dev/null
