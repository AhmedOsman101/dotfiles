# shellcheck disable=SC1090,SC1091,SC2001,SC2002,SC2016,SC2034,SC2086,SC2153,SC2154,SC2155,SC2181,SC2230,SC2250,SC2296,SC2312

# ---- Zsh config directory ---- #
export ZDOTDIR="$HOME/.config/zsh"

# Load modules safely
config_files=(
  "$ZDOTDIR/secrets.zsh"
  "$ZDOTDIR/variables.zsh"
  "$ZDOTDIR/functions.zsh"
  "$ZDOTDIR/aliases.zsh"
  "$ZDOTDIR/keybinds.zsh"
)

for file in "${config_files[@]}"; do
  [[ -f "$file" ]] && source "$file"
done

# ---- Zinit ----- #
# ---- Download Zinit, if it's not there yet ----- #
[[ ! -d "$ZINIT_HOME" ]] && mkdir -p "$(dirname "$ZINIT_HOME")"
[[ ! -d "$ZINIT_HOME"/.git ]] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"

# ---- Source/Load zinit ----- #
source "${ZINIT_HOME}/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# ---- Add in zsh prompt ----- #
autoload -Uz promptinit
promptinit

# ---- Prompt Starship ----- #
# eval "$(starship init zsh)"
zinit ice as"command" from"gh-r" \
          atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
          atpull"%atclone" src"init.zsh"
zinit light starship/starship

# ---- Add in zsh plugins ----- #
zinit light Aloxaf/fzf-tab
zinit light zdharma-continuum/fast-syntax-highlighting
zinit light "MichaelAquilina/zsh-you-should-use"
zinit light "AhmedOsman101/zsh-auto-notify-fork"
zinit light zsh-users/zsh-completions
# zinit light "marlonrichert/zsh-autocomplete"
zinit light hlissner/zsh-autopair
zinit light zsh-users/zsh-autosuggestions

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
zinit snippet OMZP::command-not-found
zinit snippet OMZP::copyfile
zinit snippet OMZP::copypath
zinit snippet OMZP::dirhistory
zinit snippet OMZP::extract

# ---- zsh options ----- #
setopt extendedglob
unsetopt nomatch
setopt AUTO_CD  # Type directory name to cd into it

# ---- History ----- #
export HISTFILE="$HOME/.zsh_history"
unsetopt extended_history     # Disable timestamps in history
setopt share_history          # Share history across shells
setopt inc_append_history     # Add commands to history immediately
setopt hist_ignore_space      # Ignore commands starting with space
setopt hist_ignore_all_dups   # Remove older duplicate entries
setopt hist_save_no_dups      # Don't save duplicates to history file
setopt hist_find_no_dups      # Skip duplicates when searching history

# ---- Completion styling ----- #
# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza --color=always --long --no-time --no-user --sort name --no-permissions --no-filesize --all --only-dirs $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'eza --color=always --long --no-time --no-user --sort name --no-permissions --no-filesize --all --only-dirs $realpath'
zstyle ':fzf-tab:complete:_files:*' fzf-preview 'eza --color=always --long --no-time --no-user --sort name --no-permissions --no-filesize --all $realpath'
zstyle ':fzf-tab:*' fzf-flags --color=fg:1,fg+:2 --bind=tab:accept

# ---- On-demand rehash ----- #
zshcache_time="$(date +%s%N)"
autoload -Uz add-zsh-hook
add-zsh-hook -Uz precmd rehash_precmd

# ---- pnpm ---- #
[[ ":$PATH:" != *":$PNPM_HOME:"* ]] && export PATH="$PNPM_HOME:$PATH"

# ---- Atuin ---- #
[[ ":$PATH:" != *":$HOME/.atuin/bin:"* ]] && export PATH="$HOME/.atuin/bin:$PATH"
eval "$(atuin init zsh)"

# ---- bun completions ---- #
[[ -s "$HOME/.bun/_bun" ]] && source "$HOME/.bun/_bun"

# ---- Asdf ---- #
source "$ASDF_DIR/asdf.sh"

# ---- Cargo ---- #
source "$CARGO_HOME/env"

# ---- FZF ----- #
source <(fzf --zsh)

# ---- The fuck alias ----- #
eval "$(thefuck --alias)"

# ---- NVM ---- #
# [[ -s "$NVM_DIR/nvm.sh" ]] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
# [[ -s "$NVM_DIR/bash_completion" ]] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

# ---- Zoxide (better cd) ---- #
eval "$(zoxide init zsh)"

no-dups -f -q $HISTFILE 2>/dev/null

# ---- Load completions ----- #
zstyle :compinstall filename $ZSHRC

autoload -Uz compinit
compinit -d "$XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION"
zinit cdreplay -q
# End of lines added by compinstall

# ---- find the command plugin ---- #
source /usr/share/doc/find-the-command/ftc.zsh noupdate

# ---- Enable better selection support ---- #
autoload -Uz select-word-style
select-word-style bash

# ---- region highlight style ---- #
zstyle ':zle:*' region-highlight 'fg=none' 'bg=#7287FD66'

# ---- Curlie ---- #
[[ -s "$HOME/.config/envman/load.sh" ]] && source "$HOME/.config/envman/load.sh"

# ---- Posting ---- #
. "$HOME/.local/share/../bin/env"

# ---- Deno ---- #
# Add deno completions to search path
if [[ ":$FPATH:" != *":$HOME/.config/zsh/completions:"* ]]; then
  export FPATH="$HOME/.config/zsh/completions:$FPATH"
fi

. "/home/othman/.deno/env"

# ---- uv ---- #
eval "$(uv generate-shell-completion zsh)"
eval "$(uvx --generate-shell-completion zsh)"

# --- git aliases (override) --- #
alias gca='git-commit --ai'
alias gl='git pull origin $(git_current_branch)'

