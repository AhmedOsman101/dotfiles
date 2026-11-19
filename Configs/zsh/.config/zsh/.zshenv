# --- XDG Standard --- #
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_STATE_HOME="${HOME}/.local/state"

# --- Zinit ---- #
# Set the directory we want to store zinit and plugins
export ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# --- Zsh config --- #
export ZDOTDIR="${XDG_CONFIG_HOME}/zsh"
export ZSHRC="${ZDOTDIR}/.zshrc"
export ZSH_CACHE_DIR="${ZSH_CACHE_DIR:-${XDG_CACHE_HOME}/zsh}"

# --- Scripts --- #
export SCRIPTS_DIR="${HOME}/scripts"

__libs__=(helpers.sh random.sh)
for __lib__ in "${__libs__[@]}"; do
  if [[ -f "${SCRIPTS_DIR}/lib/${__lib__}" ]]; then
    # shellcheck source=/dev/null
    source "${SCRIPTS_DIR}/lib/${__lib__}" || echo "Failed to source lib/${__lib__}"
  fi
done

unset __lib__ __libs__ &>/dev/null || true

# --- Rustow --- #
export DOTFILES_TARGET="${HOME}"                          # Link destination root. Default: $HOME.
export DOTFILES_DIR="${DOTFILES_TARGET}/dotfiles/Configs" # Link source, where packages live.

# --- Chassis --- #
DEVICE="$(hostnamectl chassis)"

# --- Editor --- #
for editor in hx helix nvim vim micro vi nano emacs; do
  if command -v "${editor}" &>/dev/null; then
    EDITOR="${editor}"
    break
  fi
done
export VISUAL="${EDITOR}" # VISUAL takes precedence over EDITOR

# --- Browser --- #
for browser in zen-browser zen-browser-bin thorium-browser thorium-browser-avx2 firefox chrome google-chrome google-chrome-stable; do
  if command -v "${browser}" &>/dev/null; then
    BROWSER="${browser}"
    break
  fi
done

# --- Gnupg --- #
GPG_TTY="$(tty)"

# ---- zsh-histdb setup ---- #
export HISTDB_FILE="${HOME}/.histdb/zsh-history.db"
export HISTDB_TABULATE_CMD=(column -t -s $'\x1f')

# --- Chrome --- #
CHROME_EXECUTABLE="$(command -v thorium-browser 2>/dev/null || command -v thorium-browser-avx2 2>/dev/null)"
PUPPETEER_EXECUTABLE_PATH="${CHROME_EXECUTABLE}"

# --- Xonsh --- #
export XONSH_HOME="${HOME}/.local/xonsh-env"

# --- PATH --- #
export PATH="${PATH}:${SCRIPTS_DIR}:${XONSH_HOME}/xbin:${HOME}/.local/bin"

# --- FPATH --- #
export FPATH="${ZDOTDIR}/functions:${FPATH}"

export DEVICE EDITOR BROWSER GPG_TTY CHROME_EXECUTABLE PUPPETEER_EXECUTABLE_PATH
