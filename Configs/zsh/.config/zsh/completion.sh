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

# ---- Add completions to search path (before compinit scans FPATH) ---- #
if [[ ":${FPATH}:" != *":${ZSH_CONF}/completions:"* ]]; then
  FPATH="${ZSH_CONF}/completions:${FPATH}"
fi

export FPATH="${FPATH}:/usr/share/zsh/functions:/usr/share/zsh/functions/Zle"

autoload -Uz compinit
# Fast path: skip the full fpath scan while the dump is fresh (< 24h old).
zmodload -F zsh/stat b:zstat 2>/dev/null
_zcompdump="${XDG_CACHE_HOME}/zsh/zcompdump-${ZSH_VERSION}"
_zcompdump_stale=1 # default: do the full scan
if [[ -s "${_zcompdump}" ]] && zstat -A _zcompdump_mtime +mtime -- "${_zcompdump}" 2>/dev/null; then
  _zcompdump_stale=$(( EPOCHSECONDS - _zcompdump_mtime[1] > 86400 ))
fi
if (( _zcompdump_stale )); then
  compinit -d "${_zcompdump}" # stale (>24h) or missing: full scan (once a day)
  touch -c "${_zcompdump}"    # reset the 24h clock (compinit may not rewrite the file)
else
  compinit -C -d "${_zcompdump}" # fresh: reuse dump (typical start)
fi
unset _zcompdump _zcompdump_stale _zcompdump_mtime
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
