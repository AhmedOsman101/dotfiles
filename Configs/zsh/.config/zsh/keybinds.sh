#!/usr/bin/env bash

# ---- Key Bindings ---- #
# ---- Enable emacs keybinds ---- #
bindkey -e

# ---- Bind Home and End keys ---- #
bindkey "^[[H" beginning-of-line # Home
bindkey "^[[F" end-of-line       # End

# ---- Bind Delete key ---- #
bindkey "^[[3~" delete-char # Delete

# ---- Bind Ctrl+Arrow for moving by words ---- #
bindkey "^[[1;5C" forward-word  # Ctrl+Right
bindkey "^[[1;5D" backward-word # Ctrl+Left

# ---- Undo and Redo ---- #
bindkey "^Z" undo # Ctrl+z
bindkey "^Y" redo # Ctrl+y

# ---- Clear screen and reset prompt (Ctrl+l) ---- #
ctrl_l() {
  builtin print -rn -- $'\r\e[0J\e[H\e[22J' >"${TTY}"
  builtin zle .reset-prompt
  builtin zle -R
}

zle -N ctrl_l
bindkey '^L' ctrl_l

# --- Open buffer line editor (Ctrl+x Ctrl+e) --- #
zle -N edit-command-line-sh
bindkey '^X^E' edit-command-line-sh

# ---- Copy current buffer ---- #
copybuffer() {
  if command -v clipcopy &>/dev/null; then
    clipcopy "${BUFFER}"
    zle -M "Copied buffer to clipboard"
  else
    zle -M "clipcopy not found. Please make sure you have Scripts installed correctly."
  fi
}

zle -N copybuffer

# --- Copy current terminal buffer (Ctrl+o) --- #
bindkey -M emacs "^O" copybuffer
bindkey -M viins "^O" copybuffer
bindkey -M vicmd "^O" copybuffer

# --- Magic space (Shift+tab) --- #
bindkey '^[[Z' magic-space
