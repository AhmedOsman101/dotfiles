#!/usr/bin/env bash

# ---- History ---- #
export HISTSIZE=999999
export SAVEHIST=${HISTSIZE}
export HISTFILE="${HOME}/.zsh_history"
export HISTDUP=erase
export HISTTIMEFORMAT="%F %T "
export HISTCONTROL="ignoreboth"
setopt appendhistory        # Append command to history instead of overwriting
setopt share_history        # Share history across shells
setopt hist_ignore_space    # Ignore commands starting with space
setopt hist_ignore_all_dups # Remove older duplicate entries
setopt hist_ignore_dups     # Remove older duplicate entries
setopt hist_save_no_dups    # Don't save duplicates to history file
setopt hist_find_no_dups    # Skip duplicates when searching history
setopt extended_history     # Enable timestamps in history
setopt inc_append_history   # Add commands to history immediately
setopt histreduceblanks     # Collapses runs of whitespace in history entries. Makes history cleaner.

# ---- Remove duplicate history entries (once a day) ---- #
_zhist_stamp="${XDG_CACHE_HOME}/zsh/.last-dedup"
if command -v no-dups &>/dev/null; then
  if [[ ! -s "${_zhist_stamp}" ]] || (( EPOCHSECONDS - $(<"${_zhist_stamp}") > 86400 )); then
    no-dups -f -q "${HISTFILE}"
    mkdir -p "${_zhist_stamp:h}"
    print -r -- "${EPOCHSECONDS}" >|"${_zhist_stamp}"
  fi
fi
unset _zhist_stamp
