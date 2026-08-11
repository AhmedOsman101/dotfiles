export HISTFILE="${XDG_STATE_HOME}/bash/history"

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u \W]\$ '

# ---- Starship Prompt ----- #
eval "$(starship init bash)"

complete -cf doas
complete -F _command doas

command -v deno && source "${XDG_DATA_HOME:-${HOME}/.local/share}/bash-completion/completions/deno.bash"
[[ -f '/usr/share/bash-preexec/bash-preexec.sh' ]] && source /usr/share/bash-preexec/bash-preexec.sh

# ---- Scripts ---- #
export SCRIPTS_DIR="${HOME}/scripts"

# ---- PATH ---- #
PATH="${PATH}:${HOME}/.local/bin" # my custom scripts (alternative)
PATH="${PATH}:/home/othman/.lmstudio/bin"

[[ -s "${SCRIPTS_DIR}/hooks/path.sh" ]] && source "${SCRIPTS_DIR}/hooks/path.sh"
