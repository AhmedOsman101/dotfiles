#!/usr/bin/env bash

# ---- History ---- #
setopt extended_history     # Enable timestamps in history
setopt share_history        # Share history across shells
setopt inc_append_history   # Add commands to history immediately
setopt hist_ignore_space    # Ignore commands starting with space
setopt hist_ignore_all_dups # Remove older duplicate entries
setopt hist_save_no_dups    # Don't save duplicates to history file
setopt hist_find_no_dups    # Skip duplicates when searching history

# ---- Remove duplicate history entries ---- #
command -v no-dups &>/dev/null && no-dups -f -q "${HISTFILE}"
