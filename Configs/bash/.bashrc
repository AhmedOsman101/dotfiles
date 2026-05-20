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
PATH="${PATH}:${SCRIPTS_DIR}" # my custom scripts
PATH="${PATH}:${HOME}/.local/bin" # my custom scripts (alternative)
PATH="${PATH}:/home/othman/.lmstudio/bin"

# Define patterns to exclude
EXCLUDE_PATTERNS=(
  ".git"
  ".venv"
  "venv"
  "node_modules"
)

# Dynamically add subdirectories of $SCRIPTS_DIR containing executables to PATH
# excluding specified directories and their subdirectories
if [[ -d "${SCRIPTS_DIR}" ]]; then
  for dir in $(find "${SCRIPTS_DIR}" -type f -executable -exec dirname {} \; | sort -u); do
    exclude=false
    for excluded in "${EXCLUDE_PATTERNS[@]}"; do
      # Check if 'excluded' appears as a *directory component* (e.g., /node_modules/, /.venv/)
      # Using regex: (^|/)$excluded(/|$)
      case "${dir}" in
      */"${excluded}"/* | */"${excluded}" | ^"${excluded}"/*)
        exclude=true
        break
        ;;
      *) ;; # Pass
      esac
    done

    # Also explicitly catch .venv/venv (even if dir name is "bin", parent may be venv)
    if ! ${exclude}; then
      if [[ "${dir}" =~ (^|/)(\.?venv)(/|$) ]]; then
        exclude=true
      fi
    fi

    if ! ${exclude} && [[ ":${PATH}" != *":${dir}"* ]]; then
      PATH="${PATH}:${dir}"
    fi
  done
fi

export PATH
