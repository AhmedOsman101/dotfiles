# shellcheck disable=SC2016,SC2034

# --- Load modules safely --- #
config_files=(
  "${ZDOTDIR}/variables.sh"
  "${ZDOTDIR}/functions.sh"
  "${ZDOTDIR}/aliases.sh"
  "${ZDOTDIR}/keybinds.sh"
  "${ZDOTDIR}/secrets.sh"
)

for file in "${config_files[@]}"; do
  [[ -s "${file}" ]] && source "${file}"
done

# ---- Zinit ----- #
# ---- Download Zinit, if it's not there yet ----- #
[[ ! -d "${ZINIT_HOME}" ]] && mkdir -p "$(dirname "${ZINIT_HOME}")"
[[ ! -d "${ZINIT_HOME}"/.git ]] && git clone https://github.com/zdharma-continuum/zinit.git "${ZINIT_HOME}"

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
zinit light larkery/zsh-histdb

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
setopt extended_history       # Enable timestamps in history
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
[[ ":${PATH}:" != *":${PNPM_HOME}:"* ]] && export PATH="${PNPM_HOME}:${PATH}"

# ---- Atuin ---- #
[[ ":${PATH}:" != *":${HOME}/.atuin/bin:"* ]] && export PATH="${HOME}/.atuin/bin:${PATH}"
# eval "$(atuin init zsh)"

# ---- Cargo ---- #
source "${CARGO_HOME}/env" &>/dev/null

# ---- FZF ----- #
source <(fzf --zsh)

# ---- Zoxide (better cd) ---- #
eval "$(zoxide init zsh)"

no-dups -f -q "${HISTFILE}"

# ---- Load completions ----- #
zstyle :compinstall filename "${ZSHRC}"

autoload -Uz compinit
compinit -d "${XDG_CACHE_HOME}/zsh/zcompdump-${ZSH_VERSION}"
zinit cdreplay -q
# End of lines added by compinstall

# ---- find the command plugin ---- #
ftc='/usr/share/doc/find-the-command/ftc.zsh'
[[ -s "${ftc}" ]] && source "${ftc}" noupdate

# ---- Enable better selection support ---- #
autoload -Uz select-word-style
select-word-style bash

# ---- region highlight style ---- #
zstyle ':zle:*' region-highlight 'fg=none' 'bg=none'

# ---- Curlie ---- #
[[ -s "${HOME}/.config/envman/load.sh" ]] && source "${HOME}/.config/envman/load.sh"

# Add completions to search path
if [[ ":${FPATH}:" != *":${HOME}/.config/zsh/completions:"* ]]; then
  export FPATH="${HOME}/.config/zsh/completions:${FPATH}"
fi

# ---- Deno ---- #
[[ -s "${XDG_CACHE_HOME}/deno/env" ]] && . "${XDG_CACHE_HOME}/deno/env"

# ---- uv ---- #
if command -v uv &>/dev/null; then
  eval "$(uv generate-shell-completion zsh)"
  eval "$(uvx --generate-shell-completion zsh)"
fi

# ---- rtx (asdf clone) ---- #
[[ -s "${XDG_DATA_HOME}/cargo/bin/rtx" ]] && eval "$("${XDG_DATA_HOME}/cargo/bin/rtx" activate zsh)"

# --- git aliases (override) --- #
unalias g || true
unalias gcm || true
alias gca='git-commit --ai'
alias glg="git log --all --graph --pretty=format:'%C(magenta)%h%C(default) %an %C(yellow)%ar%C(auto) %D%n%s%n'"
alias gc="git clone"
alias glc='git pull origin $(git_current_branch)'
alias glo='git pull origin'
