#!/usr/bin/env bash

# ---- Transient Prompt Configuration ---- #
# Uses zsh-transient-prompt library to make prompt transient after command execution

# ---- Full prompt (what you see while typing) ---- #
# Uses your existing Starship 2-line prompt with directory, git, and OS icon
TRANSIENT_PROMPT_PROMPT='$(starship prompt)'

# ---- Minimal transient prompt (after command runs) ---- #
# Prompt character with exit status indication (green ❯ for success, red ✗ for failure)
TRANSIENT_PROMPT_TRANSIENT_PROMPT='%(?.%F{green}❯%f.%F{red}✗%f) '

# ---- Load zsh-transient-prompt ---- #
# Must load AFTER Starship initialization (which happens in plugins.sh)
source ~/.local/share/zsh-transient-prompt/transient-prompt.zsh-theme