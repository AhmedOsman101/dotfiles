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

# ---- Ctrl+L to clear screen and reset prompt ---- #
ctrl_l() {
  builtin print -rn -- $'\r\e[0J\e[H\e[22J' >"${TTY}"
  builtin zle .reset-prompt
  builtin zle -R
}

zle -N ctrl_l
bindkey '^l' ctrl_l

# --- Open buffer line editor (Ctrl+x Ctrl+e) --- #
zle -N edit-command-line
bindkey '^x^e' edit-command-line
