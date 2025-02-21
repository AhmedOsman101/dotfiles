#!/bin/sh

# ---- Increase the FUNCNEST limit ----- #
FUNCNEST=99999

# ---- XDG Standard ---- #
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"

# ---- Tuckr ---- #
export TUCKR_DIR="$XDG_CONFIG_HOME/dotfiles/Configs"

# ---- Android ---- #
export ANDROID_USER_HOME="${XDG_DATA_HOME}/android"

# ---- asdf ---- #
export ASDF_DATA_DIR="${XDG_DATA_HOME}/asdf"
export ASDF_DIR="${ASDF_DATA_DIR}"

# ---- Astyle ---- #
export ARTISTIC_STYLE_OPTIONS="$XDG_CONFIG_HOME/.astylerc"

# ---- Bun ---- #
export BUN_INSTALL="$HOME/.bun"

# ---- Biome ---- #
export BIOME_CONFIG_PATH="$XDG_CONFIG_HOME/biome.jsonc"
export BIOME_BINARY="$(which biome)"

# ---- Cargo ---- #
export CARGO_HOME="${XDG_DATA_HOME}/cargo"

# ---- Cuda ---- #
export CUDA_CACHE_PATH="${XDG_CACHE_HOME}/nv"

# ---- Cursor ---- #
export XCURSOR_PATH="/usr/share/icons:${XDG_DATA_HOME}/icons"
export XCURSOR_THEME="Bibata"
export XCURSOR_SIZE="24"

# ---- Docker ---- #
export DOCKER_CONFIG="${XDG_CONFIG_HOME}/docker"

# ---- Dotnet ---- #
export DOTNET_CLI_HOME="${XDG_DATA_HOME}/dotnet"

# ---- FZF ----- #
# Use fd instead of fzf
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_DEFAULT_OPTS=" \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
--color=selected-bg:#45475a \
--multi"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# ---- Gnupg ---- #
export GNUPGHOME="${XDG_DATA_HOME}/gnupg"

# ---- Go ---- #
export GOPATH="${XDG_DATA_HOME}/go"

# ---- Gtk-2 ---- #
export GTK2_RC_FILES="${XDG_CONFIG_HOME}/gtk-2.0/gtkrc"

# ---- Gum ---- #
export GUM_FILTER_PROMPT="❯ "

# ---- History ----- #
export HISTSIZE=999999
export SAVEHIST=$HISTSIZE
export HISTDUP=erase
export HISTCONTROL="ignoreboth"

# ---- Libvirt ---- #
export LIBVIRT_DEFAULT_URI='qemu:///system'

# ---- Mplayer ---- #
export MPLAYER_HOME="$XDG_CONFIG_HOME/mplayer"

# ---- Micro ---- #
export EDITOR="micro"
export MICRO_TRUECOLOR=1

# ---- Node ---- #
export NODE_REPL_HISTORY="$XDG_DATA_HOME"/node_repl_history
export NODE_PACKAGE_MANAGER="pnpm"

# ---- Nuget ---- #
export NUGET_PACKAGES="$XDG_CACHE_HOME"/NuGetPackages

# ---- NVM ---- #
NVM_DIR="$XDG_DATA_HOME"/nvm

# ---- Parallel ---- #
export PARALLEL_HOME="$XDG_CONFIG_HOME"/parallel

# ---- Pass ---- #
export PASSWORD_STORE_DIR="$XDG_DATA_HOME"/pass

# ---- Pnpm ---- #
export PNPM_HOME="$XDG_DATA_HOME/pnpm"

# ---- Python ---- #
export PYTHONSTARTUP="$XDG_CONFIG_HOME/python/pythonrc"

# ---- Rustup ---- #
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup

# ---- Scripts ---- #
export SCRIPTS_DIR="$HOME/scripts"

# ---- Starship ---- #
export STARSHIP_CONFIG="$HOME/.config/starship.toml"

# ---- Terminal ---- #
export TERMINAL="kitty"
export TERM=xterm-256color
export COLORTERM=truecolor

# ---- w3m ---- #
export W3M_DIR="$XDG_DATA_HOME"/w3m

# ---- YouShouldUse utility ---- #
export YSU_MESSAGE_POSITION="after"

# ---- Zinit ----- #
# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# ---- Zsh ---- #
export ZDOTDIR="$HOME/.config/zsh"
export ZSHRC="$ZDOTDIR/.zshrc"

# Standard template for pandoc md to docx conversion
export MRT="$HOME/Documents/backup/WordTemplates/Standard.dotx"

# ---- PATH ---- #
export PATH="$PATH:$HOME/.spicetify:$HOME/.local/bin:$HOME/scripts:$HOME/scripts/python:$BUN_INSTALL/bin"
