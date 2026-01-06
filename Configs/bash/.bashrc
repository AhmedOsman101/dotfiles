export HISTFILE="${XDG_STATE_HOME}/bash/history"

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u \W]\$ '

# ---- Starship Prompt ----- #
eval "$(starship init bash)"

complete -cf doas
complete -F _command doas

source "${XDG_DATA_HOME:-${HOME}/.local/share}/bash-completion/completions/deno.bash"

# ---- Scripts ---- #
export SCRIPTS_DIR="${HOME}/scripts"

# ---- PATH ---- #
export PATH="${PATH}:${SCRIPTS_DIR}" # my custom scripts
PATH="${PATH}:${HOME}/.local/bin"    # my custom scripts (alternative)

# Define directories to exclude
EXCLUDE_DIRS=(
  "${SCRIPTS_DIR}/.git"
  "${SCRIPTS_DIR}/python/.venv"
  "${SCRIPTS_DIR}/python/venv"
)

# Dynamically add subdirectories of $HOME/scripts containing executables to PATH
# excluding specified directories and their subdirectories
if [[ -d "${SCRIPTS_DIR}" ]]; then
  for dir in $(find "${SCRIPTS_DIR}" -type f -executable -exec dirname {} \; | sort -u); do
    exclude=false
    for excluded in "${EXCLUDE_DIRS[@]}"; do
      if [[ "${dir}" == "${excluded}"* ]]; then
        exclude=true
        break
      fi
    done
    if ! ${exclude} && [[ ":${PATH}:" != *":${dir}:"* ]]; then
      PATH="${PATH}:${dir}"
    fi
  done
fi
