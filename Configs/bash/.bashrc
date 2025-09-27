export HISTFILE="${XDG_STATE_HOME}/bash/history"

# If not running interactively, don't do anything
# [[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u \W]\$ '

# ---- Prompt Starship ----- #
eval "$(starship init bash)"

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

. "$HOME/.local/share/../bin/env"

. "/home/othman/.deno/env"
source /home/othman/.local/share/bash-completion/completions/deno.bash

export PATH="$PATH:$HOME/.local/bin/scripts"

complete -cf doas
complete -F _command doas

chsh -s "$(which zsh)"

# Check for Zsh installation
if command -v zsh &>/dev/null; then
  zsh
fi

. "/mnt/main/xdg/share/../bin/env"
