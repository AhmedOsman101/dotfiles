#!/usr/bin/env bash

# ---- Key Bindings ---- #
# ---- 1. Remove emacs-style keybinds ---- #
bindkey -e # We'll override specific keys

# ---- Bind Home and End keys ---- #
bindkey "^[[H" beginning-of-line # Home
bindkey "^[[F" end-of-line       # End

# ---- Bind Delete key ---- #
bindkey "^[[3~" delete-char # Delete

# ---- Bind Ctrl+Arrow for moving by words ---- #
bindkey "^[[1;5C" forward-word  # Ctrl+Right
bindkey "^[[1;5D" backward-word # Ctrl+Left

# ---- Undo and Redo ---- #
bindkey "^z" undo
bindkey "^y" redo

zle -N ctrl_l
bindkey '^l' ctrl_l
