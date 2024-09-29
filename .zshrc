# ---- Increase the FUNCNEST limit ----- #
export FUNCNEST=200

# ---- Zinit ----- #

# ---- Set the directory we want to store zinit and plugins ----- #
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# ---- Download Zinit, if it's not there yet ----- #
if [ ! -d "$ZINIT_HOME" ]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# ---- Source/Load zinit ----- #
source "${ZINIT_HOME}/zinit.zsh"

# ---- Add in zsh prompt (pure) ----- #
autoload -Uz promptinit
promptinit
# prompt pure

zinit ice compile'(pure|async).zsh' pick'async.zsh' src'pure.zsh'
zinit light sindresorhus/pure


# ---- Add in zsh plugins ----- #
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light zdharma-continuum/fast-syntax-highlighting
# zinit light Aloxaf/fzf-tab

# ---- Add in snippets ----- #
zinit snippet OMZP::git
zinit snippet OMZP::aliases
zinit snippet OMZP::composer
zinit snippet OMZP::laravel
zinit snippet OMZP::sublime
zinit snippet OMZP::colorize

# ---- Load completions ----- #
autoload -Uz compinit && compinit
zinit cdreplay -q

# ---- History ----- #
HISTSIZE=99999
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
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
alias zshrc="code ~/.zshrc"
alias bashrc="code ~/.bashrc"
alias art="php artisan"
alias cls="clear"
alias reload="source ~/.zshrc; cls; fastfetch"
alias pnp="pnpm"
alias npm="pnpm"
alias vim="nvim"
alias apt="nala"
alias load-fonts="loadFonts"
alias vimconfig="cd ~/.config/nvim"
# ---- Zoxide (better cd) ----- #
alias cd="z"
# ---- Eza (better ls) ----- #
alias ls="eza --color=always --long --git --icons=always --no-time --no-user --all"
# ---- Trash-cli (better rm & rmdir) ----- #
alias rm="rmtrash"
alias rmdir="rmdirtrash"
# ---- Fastfetch (better neofetch) ----- #
alias neofetch="fastfetch"

# Global variables:
# MRT="C:\\Users\\Othman Enterprises\\Documents\\MarkdownReportTemplate.dotx"

# ---- Misc ----- #
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fpath+=("$(brew --prefix)/share/zsh/site-functions")

# ---- Ensure no alias for apt exists before defining the function ----- #
unalias apt 2>/dev/null
unalias sudo 2>/dev/null

apt() {
  command nala "$@"
}

sudo() {
  if [[ "$1" == "apt" ]]; then
    shift
    command sudo nala "$@"
  else
    command sudo "$@"
  fi
}

customvscode() {
  sudo chown -R $(whoami) "$(which code)"
  sudo chown -R $(whoami) /usr/share/code
}

function yy() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    builtin cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}

function loadFonts() {
  command sudo cp ~/fonts/*.ttf /usr/share/fonts/truetype/
  command sudo fc-cache -fv
}

getdiff() {
  # Generate the diff output
  git diff --staged --diff-filter=d | xargs bat --diff
}

# pnpm
export PNPM_HOME="/home/othman/.local/share/pnpm"
case ":$PATH:" in
*":$PNPM_HOME:"*) ;;
*) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

export PATH="$PATH:$HOME/.spicetify:$HOME/.local/bin:$HOME/scripts"

. "$HOME/.atuin/bin/env"

. "$HOME/.cargo/env"

eval "$(atuin init zsh)"

export TERM=xterm-256color

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
eval $(thefuck --alias)

# ---- Zoxide (better cd) ---- #
eval "$(zoxide init zsh)"
