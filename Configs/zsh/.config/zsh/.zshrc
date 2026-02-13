# shellcheck disable=SC1090,SC1091,SC2016,SC2034

# ---- Interactive shell guard ---- #
[[ -o interactive ]] || return

# ---- Zinit bootstrap ---- #
: "${ZINIT_HOME:=${XDG_DATA_HOME:-${HOME}/.local/share}/zinit}"

if [[ ! -d "${ZINIT_HOME}/.git" ]]; then
  mkdir -p "${ZINIT_HOME:h}" # NOTE: `:h` gets the head of the given file/directory (same as dirname)
  git clone 'https://github.com/zdharma-continuum/zinit.git' "${ZINIT_HOME}"
fi

# ---- Source/Load zinit ----- #
source "${ZINIT_HOME}/zinit.zsh"
autoload -Uz _zinit
[[ -n ${_comps+x} ]] && _comps[zinit]=_zinit

# ---- Load config modules ---- #
ZSH_CONF="${ZDOTDIR:-${HOME}/.config/zsh}"

MODULES=(
  variables.sh  # env, PATH (must be first)
  options.sh    # setopt / unsetopt
  functions.sh  # reusable logic
  plugins.sh    # zinit + OMZ snippets (may define aliases)
  keybinds.sh   # ZLE depends on plugins sometimes
  completion.sh # compinit, zstyle (after plugins)
  history.sh    # history options
  hooks.sh      # precmd, preexec
  aliases.sh    # MUST be late to override OMZ
  secrets.sh    # last, contains secrets like API keys (depends on gnupg and env vars)
)

for m in "${MODULES[@]}"; do
  [[ -s "${ZSH_CONF}/${m}" ]] && source "${ZSH_CONF}/${m}"
done

# ---- Load app-specific configurations ---- #
for app in "${ZSH_CONF}"/apps/*.sh; do
  [[ -s "${app}" ]] && source "${app}"
done
