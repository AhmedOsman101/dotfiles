#!/bin/sh

rehash_precmd() {
  if [[ -e /var/cache/zsh/pacman ]]; then
    local paccache_time="$(date -r /var/cache/zsh/pacman +%s%N)"
    if ( (zshcache_time <paccache_time)); then
      rehash
      zshcache_time="$paccache_time"
    fi
  fi
}

# ---- fd ---- #
# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
  cd)
    fzf --preview 'eza --tree --color=always {} | head -200' "$@"
    ;;
  export | unset)
    fzf --preview "eval 'echo {}'" "$@"
    ;;
  ssh)
    fzf --preview 'dig {}' "$@"
    ;;
  *)
    fzf --preview "$show_file_or_dir_preview" "$@"
    ;;
  esac
}

# ---- Yazi ---- #
# TODO: move to functions
yy() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(command cat -- "$tmp")" && [[ -n "$cwd" ]] && [[ "$cwd" != "$PWD" ]]; then
    builtin cd -- "$cwd" || exit
  fi
  rmtrash -f -- "$tmp"
}

# ---- quickly navigate to my dotfiles ---- #
dotfiles() {
  oldDir="$PWD"
  yy "$(dotfiles.sh $1)"
  [ "$oldDir" != "$PWD" ] && log-info "Changed directory!"
}
