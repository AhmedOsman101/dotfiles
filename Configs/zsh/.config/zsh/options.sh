#!/usr/bin/env bash

# ---- zsh modules ---- #
zmodload zsh/datetime # EPOCHSECONDS for staleness checks (completion.sh, history.sh)

# ---- zsh options ---- #
setopt extendedglob
unsetopt nomatch
setopt AUTO_CD # Type directory name to cd into it
