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
export TUCKR_HOME="${HOME}"
export TUCKR_DIR="${TUCKR_HOME}/dotfiles/Configs"

# --- Chassis --- #
export DEVICE="$(hostnamectl chassis)"

# --- Editor --- #
if command -v hx &>/dev/null; then
  export EDITOR="hx"
elif command -v helix &>/dev/null; then
  export EDITOR="helix"
elif command -v vim &>/dev/null; then
  export EDITOR="vim"
elif command -v nvim &>/dev/null; then
  export EDITOR="nvim"
elif command -v micro &>/dev/null; then
  export EDITOR="micro"
elif command -v vi &>/dev/null; then
  export EDITOR="vi"
else
  export EDITOR="nano"
fi

# --- History --- #
export HISTSIZE=999999
export SAVEHIST=${HISTSIZE}
export HISTDUP=erase
export HISTCONTROL="ignoreboth"

# --- PATH --- #
export PATH="${PATH}:${SCRIPTS_DIR}:${HOME}/.local/bin" # my custom scripts
