# shellcheck disable=SC2148

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

chsh -s "$(which zsh)"

# Check for Zsh installation
if command -v zsh &>/dev/null; then
    zsh
fi
. "$HOME/.cargo/env"
