#!/usr/bin/env bash

# ---- Key Bindings (Zsh Vi Mode) ---- #
# NOTE: ZVM config (line init mode, highlight colors) is defined
#       in plugins.sh via zvm_config() — must run before zinit loads ZVM.

# ---- Custom widgets ---- #
ctrl_l() {
  builtin print -rn -- $'\r\e[0J\e[H\e[22J' >"${TTY}"
  builtin zle .reset-prompt
  builtin zle -R
}
zle -N ctrl_l

zle -N edit-command-line-sh

copybuffer() {
  if command -v clipcopy &>/dev/null; then
    clipcopy "${BUFFER}"
    zle -M "Copied buffer to clipboard"
  else
    zle -M "clipcopy not found. Please make sure you have Scripts installed correctly."
  fi
}
zle -N copybuffer

# ---- ZVM hooks (run after ZVM init at first prompt) ---- #
function zvm_after_init() {
  # Insert mode: emacs-compatible line editing
  bindkey -M viins '^K' kill-line
  bindkey -M viins '^U' kill-whole-line
  bindkey -M viins '^W' backward-kill-word

  # Terminal escape sequences in insert mode
  bindkey -M viins "^[[H" beginning-of-line # Home
  bindkey -M viins "^[[1~" beginning-of-line
  bindkey -M viins "^[[F" end-of-line # End
  bindkey -M viins "^[[4~" end-of-line
  bindkey -M viins "^[[3~" delete-char     # Delete
  bindkey -M viins "^[[1;5C" forward-word  # Ctrl+Right
  bindkey -M viins "^[[1;5D" backward-word # Ctrl+Left

  # Custom widgets in insert mode
  bindkey -M viins '^L' ctrl_l
  # bindkey -M viins '^X^E' edit-command-line-sh
  bindkey -M viins '^O' copybuffer
  bindkey -M viins '^[[Z' magic-space
}

function zvm_after_lazy_keybindings() {
  # Helix-like line navigation
  zvm_bindkey vicmd 'gl' vi-end-of-line
  zvm_bindkey vicmd 'gs' vi-first-non-blank

  # Custom widgets in normal mode
  zvm_bindkey vicmd '^L' ctrl_l
  # zvm_bindkey vicmd '^X^E' edit-command-line-sh
  zvm_bindkey vicmd '^O' copybuffer
  zvm_bindkey vicmd '^[[Z' magic-space
  zvm_bindkey vicmd '^Z' undo
  zvm_bindkey vicmd '^Y' redo

  # Terminal escape sequences in normal mode
  zvm_bindkey vicmd "^[[H" beginning-of-line # Home
  zvm_bindkey vicmd "^[[1~" beginning-of-line
  zvm_bindkey vicmd "^[[F" end-of-line # End
  zvm_bindkey vicmd "^[[4~" end-of-line
  zvm_bindkey vicmd "^[[3~" delete-char     # Delete
  zvm_bindkey vicmd "^[[1;5C" forward-word  # Ctrl+Right
  zvm_bindkey vicmd "^[[1;5D" backward-word # Ctrl+Left
}
