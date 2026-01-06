#!/usr/bin/env bash

# ---- Atuin ---- #
[[ ":${PATH}:" != *":${HOME}/.atuin/bin:"* ]] && export PATH="${HOME}/.atuin/bin:${PATH}"
[[ -s "${HOME}/.local/bin/atuin.sh" ]] && source "${HOME}/.local/bin/atuin.sh"
