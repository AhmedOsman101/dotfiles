# shellcheck disable=SC1090,SC1091,SC2001,SC2002,SC2016,SC2034,SC2086,SC2153,SC2154,SC2155,SC2181,SC2230,SC2296,SC2312
# Above line is because shellcheck doesn't support zsh
# ---- Increase the FUNCNEST limit ----- #
FUNCSET=99999

# ---- Zinit ----- #

# ---- Set the directory we want to store zinit and plugins ----- #
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# ---- Download Zinit, if it's not there yet ----- #
[ ! -d "$ZINIT_HOME" ] && mkdir -p "$(dirname "$ZINIT_HOME")"
[ ! -d "$ZINIT_HOME"/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# ---- Add in zsh prompt ----- #
autoload -Uz promptinit
promptinit

# ---- Load completions ----- #
autoload -Uz compinit && compinit
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# ---- Source/Load zinit ----- #
source "${ZINIT_HOME}/zinit.zsh"
zinit cdreplay -q

# ---- Prompt Starship ----- #
zinit ice as"command" from"gh-r" \
          atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
          atpull"%atclone" src"init.zsh"
zinit light "starship/starship"

# ---- Add in zsh plugins ----- #
# zinit load "zsh-users/zsh-autosuggestions"
# zinit load "zsh-users/zsh-completions"
zinit load "zdharma-continuum/fast-syntax-highlighting"
# zinit load "zsh-users/zsh-syntax-highlighting"

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk

# ---- Add in snippets ----- #
zinit snippet "OMZP::git"
zinit snippet OMZP::composer
# zinit snippet OMZP::laravel
zinit snippet OMZP::command-not-found
zinit snippet OMZP::copybuffer
zinit snippet OMZP::copyfile
zinit snippet OMZP::copypath
zinit snippet OMZP::dirhistory
zinit snippet OMZP::extract

# ---- zsh options ----- #
setopt extendedglob
setopt ksh_arrays

# ---- History ----- #
export HISTFILE=~/.zsh_history
HISTSIZE=999999
SAVEHIST=$HISTSIZE
unsetopt extended_history
HISTDUP=erase
setopt share_history
setopt inc_append_history
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

noDuplicates .zsh_history 2>/dev/null

# ---- Completion styling ----- #
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# ---- Aliases ----- #
alias zshrc="micro ~/.zshrc"
alias bashrc="micro ~/.bashrc"
alias art="php artisan"
alias cls="clear"
alias reload="source ~/.zshrc && clear && neofetch"
alias pnp="pnpm"
alias npm="pnpm"
alias vim="nvim"
alias apt="nala"
# ---- Zoxide (better cd) ----- #
alias cd="z"
# ---- Eza (better ls) ----- #
alias ls="eza  --all --color=always --long --git --icons=always --no-time --no-user --sort name"
# ---- Trash-cli (better rm & rmdir) ----- #
alias rm="rmtrash"
alias rmdir="rmdirtrash"
# ---- Micro (better nano) ----- #
alias nano="micro"
# ---- ripgrep (better grep) ----- #
alias grep="rg"
alias python="python3"
alias pip="pip3"
alias getgpu="lspci -k -d ::03xx"
alias ocr="tesseract"
alias mc="micro"
alias lzg="lazygit"

# ---- On-demand rehash ----- #
zshcache_time="$(date +%s%N)"

autoload -Uz add-zsh-hook

rehash_precmd() {
  if [[ -a /var/cache/zsh/pacman ]]; then
    local paccache_time="$(date -r /var/cache/zsh/pacman +%s%N)"
    if (( zshcache_time < paccache_time )); then
      rehash
      zshcache_time="$paccache_time"
    fi
  fi
}

add-zsh-hook -Uz precmd rehash_precmd

# ---- pnpm ---- #
export PNPM_HOME="/home/othman/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# ---- Atuin ---- #
case ":${PATH}:" in
  *:"$HOME/.atuin/bin":*)
    ;;
  *)
    # Prepending path in case a system-installed binary needs to be overridden
    export PATH="$HOME/.atuin/bin:$PATH"
    ;;
esac

eval "$(atuin init zsh)"

# ---- Yazi ---- #
yy() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd" || exit
	fi
	rm -f -- "$tmp"
}

# bun completions
[ -s "/home/othman/.bun/_bun" ] && source "/home/othman/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"

export PATH="$PATH:$HOME/.spicetify:$HOME/.local/bin:$HOME/scripts:$HOME/scripts/python:$BUN_INSTALL/bin"

. "$HOME/.asdf/asdf.sh"

. "$HOME/.cargo/env"

# Standard template for pandoc for converting to docx
export MRT="$HOME/Documents/backup/WordTemplates/Standard.dotx"

export TERM=xterm-256color
export COLORTERM=truecolor

# ---- FZF ----- #
source <(fzf --zsh)

# --- Use fd instead of fzf --- #
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"

export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo ${}'"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
  esac
}

# ---- The fuck alias ----- #
eval "$(thefuck --alias)"

# ---- Key Bindings ---- #
# ---- Bind Home and End keys ---- #
bindkey "^[[H" beginning-of-line     # Home
bindkey "^[[F" end-of-line           # End

# ---- Bind Delete key ---- #
bindkey "^[[3~" delete-char          # Delete

# ---- Bind Ctrl+Arrow for moving by words ---- #
bindkey "^[[1;5C" forward-word       # Ctrl+Right
bindkey "^[[1;5D" backward-word      # Ctrl+Left

export EDITOR="micro"

export STARSHIP_CONFIG="$HOME/.config/starship.toml"

export LIBVIRT_DEFAULT_URI='qemu:///system'

export MICRO_TRUECOLOR=1

export XCURSOR_THEME="Bibata"
export XCURSOR_SIZE="24"

# Biome Config
export NODE_PACKAGE_MANAGER="pnpm"
export BIOME_CONFIG_PATH="/home/othman/.dotfiles/.config/biome.jsonc"
export BIOME_BINARY="/usr/bin/biome"

# node version manager nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export ARTISTIC_STYLE_OPTIONS="$HOME/.config/.astylerc"

# ---- Zoxide (better cd) ---- #
eval "$(zoxide init zsh)"
