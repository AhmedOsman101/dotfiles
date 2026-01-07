#!/usr/bin/env bash
# shellcheck disable=SC1090,SC2016

# ---- Completion styling ---- #
# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false

# set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'

# Case-insenstive tab completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# Add colors to the default completion menu (which is replaced by fzf)
zstyle ':completion:*' list-colors "${LS_COLORS}"

# Disable default zsh completion menu
zstyle ':completion:*' menu no

# Preview directories when using cd/zoxide completion
_cdCompletions='eza --color=always --long --no-time --no-user --sort name --no-permissions --no-filesize --all $realpath'
zstyle ':fzf-tab:complete:cd:*' fzf-preview "${_cdCompletions}"
zstyle ':fzf-tab:complete:z:*' fzf-preview "${_cdCompletions}"
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview "${_cdCompletions}"

#
zstyle ':fzf-tab:complete:_files:*' fzf-preview 'eza --color=always --long --no-time --no-user --sort name --no-permissions --no-filesize --all $realpath'
zstyle ':fzf-tab:*' fzf-flags --color=fg:1,fg+:2 --bind=tab:accept

# Enable alias finder
zstyle ':omz:plugins:alias-finder' autoload yes

# ---- Load completions ---- #
zstyle :compinstall filename "${ZSHRC}"

autoload -Uz compinit
compinit -d "${XDG_CACHE_HOME}/zsh/zcompdump-${ZSH_VERSION}"
zinit cdreplay -q
# End of lines added by compinstall

# ---- find the command plugin ---- #
ftc='/usr/share/doc/find-the-command/ftc.zsh'
[[ -s "${ftc}" ]] && source "${ftc}" quiet noupdate

# ---- Enable better selection support ---- #
autoload -Uz select-word-style
select-word-style bash

# ---- region highlight style ---- #
zstyle ':zle:*' region-highlight 'fg=none' 'bg=none'

# ---- Add completions to search path ---- #
if [[ ":${FPATH}:" != *":${ZSH_CONF}/completions:"* ]]; then
  FPATH="${ZSH_CONF}/completions:${FPATH}"
fi

export FPATH="${FPATH}:/usr/share/zsh/functions:/usr/share/zsh/functions/Zle"
