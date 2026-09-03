# shellcheck disable=SC1090,SC1091,SC2016,SC2034

# ---- Interactive shell guard ---- #
[[ -o interactive ]] || return

# ---- Concurrency guard: serialize parallel .zshrc sourcing ---- #
# tmux continuum plugin restores N panes at once -> N shells race on compinit/zinit/file writes.
# This lock is held ONLY for the duration of .zshrc sourcing, not the shell lifetime.
# Acquired here, released at EOF before tmux autostart. Falls back: flock -> zsystem -> mkdir.
if [[ -s "${ZDOTDIR:-${HOME}/.config/zsh}/lock.sh" ]]; then
  ZSHRC_LOCK_TIMEOUT=30 # seconds to wait before giving up
  source "${ZDOTDIR:-${HOME}/.config/zsh}/lock.sh"
fi

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
  'variables.sh'  # env, PATH (must be first)
  'options.sh'    # setopt / unsetopt
  'functions.sh'  # reusable logic
  'plugins.sh'    # zinit + OMZ snippets (may define aliases)
  'keybinds.sh'   # ZLE depends on plugins sometimes
  'completion.sh' # compinit, zstyle (after plugins)
  'history.sh'    # history options
  'hooks.sh'      # precmd, preexec
  'aliases.sh'    # MUST be late to override OMZ
  'secrets.sh'    # last, contains secrets like API keys (depends on gnupg and env vars)
)

for module in "${MODULES[@]}"; do
  [[ -s "${ZSH_CONF}/${module}" ]] && source "${ZSH_CONF}/${module}"
done

# ---- Load app-specific configurations ---- #
for app in "${ZSH_CONF}/apps"/*.sh; do
  [[ -s "${app}" ]] && source "${app}"
done

# ---- Release concurrency lock (held since top of file) ---- #
# Must run before tmux autostart so next queued shell can proceed immediately.
(( $+functions[_zshrc_lock_release] )) && _zshrc_lock_release 2>/dev/null || true

# Cleanup
unset MODULES module app

# ---- Auto-start tmux if not already running ---- #
tmux ls &>/dev/null || tmux
