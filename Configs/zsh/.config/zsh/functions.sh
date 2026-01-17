#!/usr/bin/env bash

if [[ -f "${HOME}/scripts/lib/helpers.sh" ]]; then
  # shellcheck disable=1091
  source "${HOME}/scripts/lib/helpers.sh" || echo "Failed to source helpers.sh"
fi

# ---- Yazi ---- #
yy() {
  local tmp cwd
  tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
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
  bash -c "help $*" | bathelp --pager=none --
}

which() {
  (
    alias
    declare -f
  ) | /usr/bin/which \
    --tty-only \
    --read-alias \
    --read-functions \
    --show-tilde \
    --show-dot \
    "$@" |
    shellfmt 2>/dev/null
}

gif() {
  printf '\n\n'
  sleep 0.2
  kitty +kitten icat "$1"
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
  if (($#)); then
    input="$*"
  else
    input="$(gum write --placeholder='Write a bash command...')"
  fi
  clipcopy "${input}"
  bash -c "${input}"
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
  sudo sh -c "du -h -d1 $1" | sort -hr
}

du() {
  sudo sh -c "du -h $1" | sort -hr
}

ffprobe() {
  command ffprobe -v error \
    -select_streams v:0 \
    -show_entries stream=codec_name,width,height,avg_frame_rate,bit_rate \
    -of default=noprint_wrappers=1:nokey=0 \
    "$@"
}

touch() {
  local dir
  for file in "$@"; do
    if [[ ! -f "${file}" ]]; then
      dir="$(dirname "${file}")"
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
  local lines=0
  local limit count

  builtin cd "${PWD}" || return 1

  flags+=(
    --paging=auto
    --style=plain
    --color=auto
  )

  for arg in "$@"; do
    if [[ -r "${arg}" ]]; then
      count=$(wc -l "${arg}" | awk '{print $1}')
      lines=$((lines + count))
    fi
  done

  ((lines *= 100))
  limit=$(((COLUMNS / 2) * 100))

  ((lines > limit)) && flags+=(--pager=builtin)

  command bat "${flags[@]}" "$@"
}

bathelp() {
  command bat --language=help --style=plain --color=auto "$@"
}

vite() {
  trap 'printf "\r"; log-info "Vite interrupted, cleaning started..."' INT
  command vite --config "${XDG_CONFIG_HOME}/vite/vite.config.js" "$@"
  for arg in "$@"; do
    if [[ -d "${arg}" && -d "${arg}/.vite" ]]; then
      gum confirm "Remove ${arg}/.vite directory?" && rm -r "${arg}/.vite"
      break
    fi
  done

  eraseLine  # cleanup
  trap - INT # restore default
}

pdf2png() {
  pdftocairo -png -r 300 "$1" "${1%.pdf}"
}

# --- TGPT --- #
tgpt() {
  if [[ -z "$1" ]]; then
    command tgpt "$(gum write --placeholder "Write your message...")"
  else
    command tgpt "$@"
  fi
}
# 1. Shell Assistant Mode (-s)
# Optimized for generating and executing commands
t-sh() {
  local prompt
  prompt="$(gum write --placeholder "Describe the shell command you need..." --width 80)"

  if [[ -n "${prompt}" ]]; then
    command tgpt --shell "${prompt}"
  else
    log-info "Nothing to do..."
  fi
}

# 2. Code Generation Mode (-c)
# Uses phind (default) for high-quality dev responses
t-code() {
  local prompt
  prompt="$(gum write --placeholder "Describe the code/script to generate..." --width 80)"
  if [[ -n "${prompt}" ]]; then
    command tgpt --code "${prompt}"
  else
    log-info "Nothing to do..."
  fi
}

# 3. Image Generation Mode (-img)
# Defaults to Pollinations and asks for a filename
t-img() {
  local prompt filename
  prompt="$(gum write --placeholder "Describe the image to generate..." --width 80)"

  [[ -z "${prompt}" ]] && return

  filename="$(gum input --placeholder "Output filename (e.g., wallpaper.jpg)")"

  [[ -z "${filename}" ]] && filename="output.jpg"

  command tgpt --image --out "${filename}" "${prompt}"
  log-info "Image saved to: ${filename}"
}

# 4. Search/Research Mode (isou)
# Specifically uses the 'isou' provider for web search
t-search() {
  local prompt
  prompt="$(gum write --placeholder "Enter your research query (Web Search)..." --width 80)"
  if [[ -n "${prompt}" ]]; then
    command tgpt --provider isou "${prompt}"
  else
    log-info "Nothing to do..."
  fi
}

# 5. Full Interactive Mode (-m)
# Starts a persistent session with Phind
t-chat() {
  command tgpt --multiline
}

ai() {
  local mode
  mode=$(gum choose \
    "Shell (Execute Commands)" \
    "Code (Write Scripts)" \
    "Search (Web/Research)" \
    "Chat (Interactive)" \
    "Image (Generation)" \
    "Exit")

  case "${mode}" in
  "Shell (Execute Commands)") t-sh ;;
  "Code (Write Scripts)") t-code ;;
  "Search (Web/Research)") t-search ;;
  "Chat (Interactive)") t-chat ;;
  "Image (Generation)") t-img ;;
  "Exit" | *) return 0 ;;
  esac
}

# ---- Eza (better ls) ----- #
# Common flags for all eza calls
_eza_common_flags=(
  '--all'
  '--color=auto'
  '--long'
  '--icons'
  '--no-time'
  '--no-user'
  '--sort=name'
  '--group-directories-first'
)

# Ignore pattern for tree listings
_eza_ignore_glob="node_modules|.turbo|dist|build|.next|.nuxt|.git|vendor"

# Common flags for tree listings
_tree_common_flags=(
  "${_eza_common_flags[@]}"
  "--ignore-glob=${_eza_ignore_glob}"
  '--no-permissions'
  '--tree'
)

ls() {
  local args=("$@")

  # Try with --total-size first, with timeout
  if ! timeout 3 eza "${_eza_common_flags[@]}" --total-size "${args[@]}"; then
    # fallback without --total-size
    eza "${_eza_common_flags[@]}" "${args[@]}"
  fi
}

lsu() {
  local args=("$@")

  # Try with --total-size first, with timeout
  if ! timeout 3 sudo -A eza "${_eza_common_flags[@]}" --total-size "${args[@]}"; then
    # fallback without --total-size
    sudo -A eza "${_eza_common_flags[@]}" "${args[@]}"
  fi
}

lst() {
  local args=("$@")

  if ! timeout 3 eza "${_tree_common_flags[@]}" --total-size "${args[@]}"; then
    eza "${_tree_common_flags[@]}" "${args[@]}"
  fi
}

lstu() {
  local args=("$@")

  if ! timeout 3 sudo -A eza "${_tree_common_flags[@]}" --total-size "${args[@]}"; then
    sudo -A eza "${_tree_common_flags[@]}" "${args[@]}"
  fi
}

advrm() {
  local dir="$1" total_files total_dirs

  total_files="$(find "${dir}" -type f | wc -l)"
  total_dirs="$(find "${dir}" -type d | wc -l)"

  log-info "Deleting ${total_dirs} directories with ${total_files} files"
  find "${dir}" -type f -print0 | pv -0 -l -s "${total_files}" | xargs -0 rm -f
  rm -rf "${dir}" # remove empty directories
}
