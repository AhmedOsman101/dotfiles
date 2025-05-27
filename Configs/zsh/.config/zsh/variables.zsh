#!/bin/sh

# ---- Increase the FUNCNEST limit ----- #
FUNCNEST=99999
export SHLVL=10
# ---- XDG Standard ---- #
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"

# ---- Tuckr ---- #
export TUCKR_HOME="$HOME"
export TUCKR_DIR="$TUCKR_HOME/dotfiles/Configs"

# ---- Auto Notify ---- #
export AUTO_NOTIFY_IGNORE=(
  "vim" "nvim" "micro" "hx"
  "helix" "nano" "less" "more"
  "man" "bat" "tig" "watch"
  "git commit" "top" "htop" "btop"
  "yazi" "yy" "dotfiles" "dm"
  "watchexec" "biome-watch" "lzg" "lazygit"
  "ssh" "fzf" "deno" "posting"
  "scrcpy" "wavemon" "mkscript" "toipe"
  "flameshot" "frogmouth" "vi" "ncdu"
  "nu" "pnpm dev" "npm dev" "editwhich"
  "n" "tempedit" "bun run" "bunx"
  "sudoedit" "distrobox" "db"
)
export AUTO_NOTIFY_THRESHOLD=30
export AUTO_NOTIFY_ICON_SUCCESS="/usr/share/icons/auto-notify-zsh/success.png"
export AUTO_NOTIFY_ICON_FAILURE="/usr/share/icons/auto-notify-zsh/fail.png"

# ---- Android ---- #
export ANDROID_USER_HOME="${XDG_DATA_HOME}/android"
export ANDROID_HOME="${XDG_DATA_HOME}/android/sdk"

# ---- Asdf ---- #
export ASDF_DATA_DIR="${XDG_DATA_HOME}/asdf"
export ASDF_DIR="${ASDF_DATA_DIR}"

# ---- Astyle ---- #
export ARTISTIC_STYLE_OPTIONS="$XDG_CONFIG_HOME/.astylerc"
export ARTISTIC_STYLE_PROJECT_OPTIONS="$XDG_CONFIG_HOME/.astylerc"

# ---- Bat ---- #
export BATDIFF_USE_DELTA=true

# ---- Bun ---- #
export BUN_INSTALL="$HOME/.bun"

# ---- Biome ---- #
export BIOME_CONFIG_PATH="$XDG_CONFIG_HOME/biome.jsonc"
export BIOME_BINARY="$(which biome)"

# ---- Browser ---- #
export BROWSER="zen-browser"

# ---- Cargo ---- #
export CARGO_HOME="${XDG_DATA_HOME}/cargo"

# ---- Cuda ---- #
export CUDA_CACHE_PATH="${XDG_CACHE_HOME}/nv"

# ---- Cursor ---- #
export XCURSOR_PATH="/usr/share/icons:${XDG_DATA_HOME}/icons"
export XCURSOR_THEME="Bibata-Modern-Ice"
export XCURSOR_SIZE="26"

# ---- Colors ---- #
export U_BLACK="#14141E"
export U_RED="#F7768E"
export U_GREEN="#35BF88"
export U_YELLOW="#DBAC66"
export U_BLUE="#4CA6E8"
export U_MAGENTA="#BB9AF7"
export U_CYAN="#7DCFFF"
export U_WHITE="#E6E6E8"
export U_GRAY="#B5BCC9"
export U_ORANGE="#EFCA84"
export U_PURPLE="#7AA2F7"

# ---- Docker ---- #
export DOCKER_CONFIG="${XDG_CONFIG_HOME}/docker"

# ---- Dotnet ---- #
export DOTNET_CLI_HOME="${XDG_DATA_HOME}/dotnet"

# ---- Doas ---- #
export DOAS_NOPASS="${XDG_CONFIG_HOME}/doas/doas.conf"

#---- Editor ---- #
export EDITOR="hx" # helix

# ---- FZF ----- #
show_file_or_dir_preview="if [ -d {} ]; then eza --all --tree --color=always {} | head -200; else if [[ {} =~ \.(md|markdown)$ ]]; then mdcat {}; else bat --color=always --line-range :500 {}; fi; fi"

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
# ---- Filter ---- #
export GUM_FILTER_PROMPT="❯ "
export GUM_FILTER_INDICATOR_FOREGROUND="${U_CYAN}"
export GUM_FILTER_MATCH_FOREGROUND="${U_CYAN}"
export GUM_FILTER_PROMPT_FOREGROUND="${U_CYAN}"
export GUM_FILTER_HEADER_FOREGROUND="${U_BLUE}"
#---- Choose ---- #
export GUM_CONFIRM_PROMPT_FOREGROUND="${U_PURPLE}"
export GUM_CONFIRM_SELECTED_FOREGROUND="${U_BLACK}"
export GUM_CONFIRM_SELECTED_BACKGROUND="${U_PURPLE}"
# export GUM_CONFIRM_SELECTED_BACKGROUND="${U_GREEN}"
#---- Choose ---- #
export GUM_CHOOSE_CURSOR="❯ "
export GUM_CHOOSE_CURSOR_FOREGROUND="${U_CYAN}"
export GUM_CHOOSE_SELECTED_FOREGROUND="${U_CYAN}"
export GUM_CHOOSE_HEADER_FOREGROUND="${U_BLUE}"
#---- Input ---- #
export GUM_INPUT_PROMPT="❯ "
export GUM_INPUT_PROMPT_FOREGROUND="${U_CYAN}"
export GUM_INPUT_HEADER_FOREGROUND="${U_GRAY}"
export GUM_INPUT_CURSOR_FOREGROUND="${U_CYAN}"
#---- Spinner ---- #
export GUM_SPIN_SPINNER_FOREGROUND="${U_GREEN}"
export GUM_SPIN_TITLE_FOREGROUND="${U_GREEN}"
#---- Write ---- #
export GUM_WRITE_CURSOR_FOREGROUND="${U_GRAY}"
#---- File ---- #
export GUM_FILE_CURSOR="❯ "
export GUM_FILE_HEIGHT=20
export GUM_FILE_SYMLINK_FOREGROUND="${U_GREEN}"
export GUM_FILE_DIRECTORY_FOREGROUND="${U_PURPLE}"
export GUM_FILE_CURSOR_FOREGROUND="${U_ORANGE}"
export GUM_FILE_SELECTED_FOREGROUND="${U_ORANGE}"
export GUM_FILE_HEADER_FOREGROUND="${U_CYAN}"

# ---- History ----- #
export HISTSIZE=999999
export SAVEHIST=$HISTSIZE
export HISTDUP=erase
export HISTCONTROL="ignoreboth"

# ---- Libvirt ---- #
export LIBVIRT_DEFAULT_URI='qemu:///system'

# ---- Man ---- #
export MANROFFOPT="-c"
export MANPAGER="sh -c 'col -bx | bat --paging=always --language=man -p'"
export LESS_TERMCAP_md=$'\e[01;32m' # Green for bold
export LESS_TERMCAP_me=$'\e[0m'

# ---- Mplayer ---- #
export MPLAYER_HOME="$XDG_CONFIG_HOME/mplayer"

# ---- Micro ---- #
export MICRO_TRUECOLOR=1

# ---- Misc ---- #
export AUTHOR="Ahmad Othman"
export AUTHOR_EMAIL="ahmad.ali.othman@outlook.com"

# ---- Node ---- #
export NODE_REPL_HISTORY="$XDG_DATA_HOME/node_repl_history"
export NODE_PACKAGE_MANAGER="pnpm"

# ---- Nuget ---- #
export NUGET_PACKAGES="$XDG_CACHE_HOME/NuGetPackages"

# ---- NVM ---- #
export NVM_DIR="$XDG_DATA_HOME/nvm"

# ---- NU Shell ---- #
export NU_CONFIG="$XDG_CONFIG_HOME/nushell/config.nu"

# ---- Parallel ---- #
export PARALLEL_HOME="$XDG_CONFIG_HOME/parallel"

# ---- Pass ---- #
export PASSWORD_STORE_DIR="$XDG_DATA_HOME/pass"

# ---- Pnpm ---- #
export PNPM_HOME="$XDG_DATA_HOME/pnpm"

# ---- Python ---- #
export PYTHONSTARTUP="$XDG_CONFIG_HOME/python/pythonrc"

# ---- Prettier ---- #
export PRETTIERRC="${XDG_CONFIG_HOME}/.prettierrc.json"

# ---- Rustup ---- #
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"

# ---- Scripts ---- #
export SCRIPTS_DIR="$HOME/scripts"

# ---- Starship ---- #
export STARSHIP_CONFIG="$HOME/.config/starship.toml"

# ---- Sudo ---- #
export SUDO_ASKPASS="/home/othman/scripts/rofi/rofi-askpass"

# ---- Terminal ---- #
export TERMINAL="kitty"
export TERM=xterm-256color
export COLORTERM=truecolor

# ---- Texfm ---- #
export TEXMFVAR="$XDG_CACHE_HOME/texlive/texmf-var"

# ---- w3m ---- #
export W3M_DIR="$XDG_DATA_HOME/w3m"

# ---- X11 ---- #
export XINITRC="$XDG_CONFIG_HOME/X11/.Xinitrc"

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
export PATH="$PATH:$HOME/.local/bin"
PATH="$PATH:$SCRIPTS_DIR"                            # my custom scripts
PATH="$PATH:$HOME/.spicetify"                        # spicetify for spotify mods
PATH="$PATH:$BUN_INSTALL/bin"                        # BUN js runtime
PATH="$PATH:$HOME/.local/share/gem/ruby/3.4.0/bin"   # Ruby gems
PATH="$PATH:$XDG_CONFIG_HOME/composer/vendor/bin"    # Composer packages
PATH="$PATH:$CARGO_HOME/bin"                         # Cargo packages
PATH="$PATH:${ASDF_DATA_DIR}/shims"                  # Asdf shims

# Define directories to exclude
EXCLUDE_DIRS=(
  "${SCRIPTS_DIR}/.git"
  "${SCRIPTS_DIR}/python/.venv"
  "${SCRIPTS_DIR}/python/venv"
)

# Dynamically add subdirectories of $HOME/scripts containing executables to PATH
# excluding specified directories and their subdirectories
if [ -d "$SCRIPTS_DIR" ]; then
  for dir in $(find "$SCRIPTS_DIR" -type f -executable -exec dirname {} \; | sort -u); do
    exclude=false
    for excluded in "${EXCLUDE_DIRS[@]}"; do
      if [[ "$dir" == "$excluded"* ]]; then
        exclude=true
        break
      fi
    done
    if ! $exclude && [[ ":$PATH:" != *":$dir:"* ]]; then
      PATH="$PATH:$dir"
    fi
  done
fi
