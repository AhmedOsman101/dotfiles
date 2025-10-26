#!/usr/bin/env bash

if [[ -f "${HOME}/scripts/lib/helpers.sh" ]]; then
  source "${HOME}/scripts/lib/helpers.sh" || echo "Failed to source helpers.sh"
fi

rehash_precmd() {
  if [[ -e /var/cache/zsh/pacman ]]; then
    local paccache_time="$(date -r /var/cache/zsh/pacman +%s%N)"
    if ((zshcache_time < paccache_time)); then
      rehash
      zshcache_time="${paccache_time}"
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

  case "${command}" in
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
    fzf --preview "${show_file_or_dir_preview}" "$@"
    ;;
  esac
}

# ---- Yazi ---- #
yy() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  yazi "$@" --cwd-file="${tmp}"
  if cwd="$(command cat -- "${tmp}")" && [[ -n "${cwd}" ]] && [[ "${cwd}" != "${PWD}" ]]; then
    builtin cd -- "${cwd}" || exit
  fi
  rm -f -- "${tmp}"
}

# ---- quickly navigate to my dotfiles ---- #
dotfiles() {
  oldDir="${PWD}"
  target=$(dotfiles.sh "$1") || {
    eraseLine
    log-info "Nothing selected"
    return 0
  }
  yy "${target}"
  [[ "${oldDir}" != "${PWD}" ]] && log-info "Changed directory!"
  return 0
}

help() {
  bash -c "help $*" | bathelp -- --pager=none
}

which() {
  (
    alias
    declare -f
  ) | /usr/bin/which --tty-only --read-alias --read-functions --show-tilde --show-dot "$@"
}

gif() {
  printf '\n\n'
  sleep 0.2
  kitty +kitten icat "$1"
}

ctrl_l() {
  builtin print -rn -- $'\r\e[0J\e[H\e[22J' >"${TTY}"
  builtin zle .reset-prompt
  builtin zle -R
}

gcm() {
  # resolves to "git clone git@github.com:AhmedOsman101/"
  local repo="$1"
  shift
  git clone "me:${repo}" "$@"
}

gcg() {
  # resolves to "git clone git@github.com:"
  local repo="$1"
  shift
  git clone "gh:${repo}" "$@"
}

cr() {
  cargo run --quiet "${@}" || true
}

ccr() {
  clear
  cargo run --quiet "${@}" || true
}

bashc() {
  if (($# < 1)); then
    input="$(gum write --placeholder='Write a bash command...')"
  else
    input="$*"
  fi
  bash -c "${input}"
  return $?
}

# ---- Qalculate ---- #
calc() {
  local expression="$1"
  [[ -z "${expression}" ]] && expression="$(gum input)"
  # NOTE: Using the `command` builtin to avoid calling the function recursively
  command qalc --base 10 --color --terse "${expression}"
  return 0
}

qalc() {
  local expression=$1
  [[ -z "${expression}" ]] && expression="$(gum input)"
  # NOTE: Using the `command` builtin to avoid calling the function recursively
  command qalc --base 10 --color "${expression}" || true
  return 0
}

du-dir() {
  sudo du -h -d1 "$1" | sort -hr
}

ffprobe() {
  command ffprobe -v error \
    -select_streams v:0 \
    -show_entries stream=codec_name,width,height,avg_frame_rate,bit_rate \
    -of default=noprint_wrappers=1:nokey=0 \
    "$@"
}

touch() {
  for file in "$@"; do
    if [[ ! -f "${file}" ]]; then
      local dir="$(dirname "${file}")"
      if [[ ! -d "${dir}" ]]; then
        if ! mkdir -p "${dir}"; then
          log-warning "Couldn't create parent directory, skipping file: ${file}"
          continue
        fi
      fi
    fi
    command touch "${file}"
  done
}

bat() {
  local -a flags
  local lines=$((0)) count

  builtin cd "${PWD}" || return 1

  flags+=(
    --paging=auto
    --style=plain
    --color=auto
  )

  for arg in "$@"; do
    if [[ -f "${arg}" ]]; then
      count=$(wc -l "${arg}" | awk '{print $1}')
      lines=$((lines + count))
    fi
  done

  ((lines *= 100))
  local limit
  limit=$(((COLUMNS / 2) * 100))

  ((lines > limit)) && flags+=(--pager=builtin)

  command bat "${flags[@]}" "$@"
}

vite() {
  trap 'printf "\r"; log-info "Vite interrupted, started cleaning"' INT
  command vite --config "${XDG_CONFIG_HOME}/vite/vite.config.js" "$@"
  for arg in "$@"; do
    if [[ -d "${arg}" && -d "${arg}/.vite" ]]; then
      gum confirm "Remove .vite directory?" && rm -r "${arg}/.vite"
      break
    fi
  done

  eraseLine  # cleanup
  trap - INT # restore default
}

# Runs before any command
# precmd() { }

# Runs when changing directories
# chpwd() { }

# Runs after any command
# preexec() { }
