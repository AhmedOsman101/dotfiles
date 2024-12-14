# shellcheck disable=SC2034,SC2153,SC2086,SC2155,SC2016,SC1091,SC2296
# Above line is because shellcheck doesn't support zsh
# ---- Increase the FUNCNEST limit ----- #
FUNCSET=99999

# ---- Zinit ----- #

# ---- Set the directory we want to store zinit and plugins ----- #
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# ---- Download Zinit, if it's not there yet ----- #
if [ ! -d "$ZINIT_HOME" ]; then
  bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"
fi

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
zinit light 'starship/starship'

# ---- Add in zsh plugins ----- #
zinit load zsh-users/zsh-syntax-highlighting
zinit load zsh-users/zsh-completions
zinit load zsh-users/zsh-autosuggestions
zinit load zdharma-continuum/fast-syntax-highlighting

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk

# ---- Add in snippets ----- #
zinit snippet OMZP::git
zinit snippet OMZP::aliases
zinit snippet OMZP::composer
zinit snippet OMZP::laravel
zinit snippet OMZP::sublime
zinit snippet OMZP::colorize
zinit snippet OMZP::asdf

# ---- zsh options ----- #
setopt extendedglob
setopt ksh_arrays

# ---- History ----- #
export HISTFILE=~/.zsh_history
HISTSIZE=999999
HISTFILE=~/.zsh_history
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
alias reload="source ~/.zshrc && clear; neofetch"
alias pnp="pnpm"
alias npm="pnpm"
alias vim="nvim"
alias apt="nala"
alias vimconfig="cd ~/.config/nvim"
# ---- Zoxide (better cd) ----- #
alias cd="z"
# ---- Eza (better ls) ----- #
alias ls="eza --color=always --long --git --icons=always --no-time --no-user --all"
# ---- Trash-cli (better rm & rmdir) ----- #
alias rm="rmtrash"
alias rmdir="rmdirtrash"
# ---- Micro (better Nano) ----- #
alias nano="micro"
alias python="python3"
alias pip="pip3"

# ---- Homebrew ----- #
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fpath+=("$(brew --prefix)/share/zsh/site-functions")

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

# ---- Ensure no alias for apt exists before defining the function ----- #
unalias apt 2>/dev/null
unalias sudo 2>/dev/null

# pnpm
export PNPM_HOME="/home/othman/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# atuin
case ":${PATH}:" in
    *:"$HOME/.atuin/bin":*)
        ;;
    *)
        # Prepending path in case a system-installed binary needs to be overridden
        export PATH="$HOME/.atuin/bin:$PATH"
        ;;
esac

eval "$(atuin init zsh)"

# Yazi

yy() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# bun completions
[ -s "/home/othman/.bun/_bun" ] && source "/home/othman/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"

export PATH="$PATH:$HOME/.spicetify:$HOME/.local/bin:$HOME/scripts:/home/linuxbrew/.linuxbrew/bin:$BUN_INSTALL/bin"

# shellcheck disable=SC1091
. "$HOME/.asdf/asdf.sh"

export TERM=xterm-256color
export COLORTERM=truecolor

# ---- FZF ----- #
# shellcheck disable=SC1090
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

# ---- Zoxide (better cd) ---- #
eval "$(zoxide init zsh)"

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

export STARSHIP_CONFIG=~/.config/starship.toml

export LIBVIRT_DEFAULT_URI='qemu:///system'
export "MICRO_TRUECOLOR=1"
