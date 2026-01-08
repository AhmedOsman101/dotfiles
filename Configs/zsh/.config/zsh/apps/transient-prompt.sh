#!/usr/bin/env bash
# shellcheck disable=1090,1091,2016,2034
# ---- Transient Prompt Configuration ---- #
# Uses zsh-transient-prompt library to make prompt transient after command execution

# ---- Full prompt (what you see while typing) ---- #
# Uses your existing Starship 2-line prompt with directory, git, and OS icon
TRANSIENT_PROMPT_PROMPT=$'$(starship prompt)'
# ---- Load zsh-transient-prompt ---- #
# Must load AFTER Starship initialization (which happens in plugins.sh)
# NOTE: zinit now manages the plugin download and updating (happens in plugins.sh)
source "${ZINIT_HOME}/../plugins/olets---zsh-transient-prompt/transient-prompt.zsh-theme"

# ---- Minimal transient prompt (after command runs) ---- #
typeset -g LAST_EXECUTED_CMD=""

function transient_preexec() {
  LAST_EXECUTED_CMD=$1
}

function transient_precmd() {
  # $status is a read-only variable (reserved by shell)
  local _status=$?

  if ((_status == 0)); then
    TRANSIENT_CHAR='%F{green}❯%f '
  else
    TRANSIENT_CHAR='%F{red}✗%f '
  fi
  printf '\n'
}

add-zsh-hook preexec transient_preexec
add-zsh-hook precmd transient_precmd

# This sets the prompt for the next command not the previous one
TRANSIENT_PROMPT_TRANSIENT_PROMPT=$'$TRANSIENT_CHAR'
