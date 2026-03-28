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

# --- Scripts --- #
export SCRIPTS_DIR="${HOME}/scripts"

# --- Tuckr --- #
export TUCKR_HOME="${HOME}/dotfiles"
export TUCKR_DIR="${TUCKR_HOME}/Configs"

# --- Chassis --- #
DEVICE="$(hostnamectl chassis)"

# --- Editor --- #
for editor in hx helix nvim vim vi micro nano emacs; do
  if command -v "${editor}" &>/dev/null; then
    EDITOR="${editor}"
    break
  fi
done
export VISUAL="${EDITOR}" # VISUAL takes precedence over EDITOR

# --- Browser --- #
for browser in zen-browser thorium-browser firefox; do
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

# --- PATH --- #
export PATH="${PATH}:${SCRIPTS_DIR}:${HOME}/.local/bin" # my custom scripts

# --- FPATH --- #
export FPATH="${ZDOTDIR}/functions:${FPATH}"

export DEVICE EDITOR BROWSER GPG_TTY
