#!/usr/bin/env bash
# shellcheck disable=SC2034

# ---- History ---- #
HISTSIZE=999999
SAVEHIST=${HISTSIZE}
HISTFILE="${HOME}/.zsh_history"
HISTDUP=erase
HISTTIMEFORMAT="%F %T "
HISTCONTROL="ignoreboth"
setopt appendhistory        # Append command to history instead of overwriting
setopt share_history        # Share history across shells
setopt hist_ignore_space    # Ignore commands starting with space
setopt hist_ignore_all_dups # Remove older duplicate entries
setopt hist_ignore_dups     # Remove older duplicate entries
setopt hist_save_no_dups    # Don't save duplicates to history file
setopt hist_find_no_dups    # Skip duplicates when searching history
setopt extended_history     # Enable timestamps in history
setopt inc_append_history   # Add commands to history immediately

# ---- Remove duplicate history entries ---- #
command -v no-dups &>/dev/null && no-dups -f -q "${HISTFILE}"
