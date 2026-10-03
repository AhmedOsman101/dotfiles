export HISTCONTROL="ignoreboth"
export HISTDUP=erase
export HISTFILE="${XDG_STATE_HOME}/bash/history"
export HISTSIZE=999999
export HISTTIMEFORMAT="%F %T "
export SAVEHIST=${HISTSIZE}

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u \W]\$ '

# --- Shell Options --- #
shopt -s autocd    # typing a directory name as a command changes to that directory.
shopt -s cdspell   # `cd` corrects minor spelling errors in directory names.
shopt -s checkjobs # interactive shell warns about stopped/running jobs before exiting.
shopt -s globstar  # `**` matches zero or more directories/subdirectories in filename expansion.
shopt -s histappend # history is appended to `HISTFILE` on exit instead of overwriting it.
shopt -s nocaseglob # filename expansion is case-insensitive.

# ---- Starship Prompt ----- #
eval "$(starship init bash)"

complete -cf doas
complete -F _command doas

if command -v deno &>/dev/null; then
  # shellcheck source=/dev/null
  source "${XDG_DATA_HOME:-${HOME}/.local/share}/bash-completion/completions/deno.bash"
fi
if [[ -f '/usr/share/bash-preexec/bash-preexec.sh' ]]; then
  # shellcheck source=/dev/null
  source /usr/share/bash-preexec/bash-preexec.sh
fi

# ---- Scripts ---- #
export SCRIPTS_DIR="${HOME}/scripts"

# ---- PATH ---- #
MODULES=(
  '.zshenv'      # Important variables (must be first)
  'variables.sh' # env, PATH
)

for module in "${MODULES[@]}"; do
  if [[ -s "${ZDOTDIR}/${module}" ]] && bash -n "${ZDOTDIR}/${module}"; then
    # shellcheck source=/home/othman/.config/zsh
    source "${ZDOTDIR}/${module}"
  fi
done
unset MODULES module

export PATH
