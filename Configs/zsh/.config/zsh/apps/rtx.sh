#!/usr/bin/env bash

# ---- rtx (asdf clone) ---- #
[[ -s "${XDG_DATA_HOME}/cargo/bin/rtx" ]] && eval "$("${XDG_DATA_HOME}/cargo/bin/rtx" activate zsh)"
