#!/usr/bin/env bash
# shellcheck disable=SC1090,SC2016

# ---- Completion styling ---- #
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

# ---- Load completions ---- #
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

# ---- Add completions to search path ---- #
if [[ ":${FPATH}:" != *":${ZSH_CONF}/completions:"* ]]; then
  export FPATH="${ZSH_CONF}/completions:${FPATH}"
fi
