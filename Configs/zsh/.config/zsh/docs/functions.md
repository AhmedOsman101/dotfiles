# Functions Reference

Source: `functions.sh` (loaded 3rd, after `variables.sh`). Helpers from `${SCRIPTS_DIR}/lib/helpers.sh` are sourced first (`log-info`, `collapseTilde`, `clipcopy`, `eraseLine`, `printBold`, …).

---

## File Navigation

### `yy [args…]` — Yazi with cwd tracking

Opens [Yazi](https://yazi-rs.github.io) and `cd`s to its final directory.

```zsh
yy() {
  local tmp cwd
  tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
  yazi "$@" --cwd-file="${tmp}"
  if cwd="$(command cat -- "${tmp}")" && [[ -n "${cwd}" ]] && [[ "${cwd}" != "${PWD}" ]]; then
    builtin cd -- "${cwd}" || exit
  fi
  rm -f -- "${tmp}"
}
```

### `dotfiles [filter]` — Browse dotfiles via Yazi

```zsh
dotfiles() {
  oldDir="${PWD}"
  target=$(dotfiles.sh "$1") || { eraseLine; log-info "Nothing selected"; return 0 }
  yy "${target}"
  [[ "${oldDir}" != "${PWD}" ]] && log-info "Changed directory!"
}
```

Uses `dotfiles.sh` selector; opens result in `yy`.

### `ls` / `lsu` / `lst` / `lstu` — Eza wrappers

Shared flags:

```zsh
_eza_common_flags=(--all --color=auto --long --icons --no-time --no-user --sort=name --group-directories-first)
_tree_common_flags=("${_eza_common_flags[@]}" --ignore-glob='node_modules|.turbo|dist|build|.next|.nuxt|.git|vendor' --no-permissions --tree)
```

| Function | Command | Timeout |
|----------|---------|---------|
| `ls [args]` | `eza "${_eza_common_flags[@]}" --total-size` → fallback without `--total-size` | 3s |
| `lsu [args]` | `sudo -A eza … --total-size` → fallback | 5s |
| `lst [args]` | `eza "${_tree_common_flags[@]}" --total-size` → fallback | 3s |
| `lstu [args]` | `sudo -A eza … --total-size` → fallback | 5s |

Timeout via `timeout 3/5`; avoids hanging on large trees.

---

## Git

### `gcm <repo> [args…]` — Clone from personal GitHub

```zsh
gcm "my-repo"  # → git clone "me:my-repo" (git@github.com:AhmedOsman101/my-repo via git config url.<>.insteadOf)
```

### `gcg <user/repo> [args…]` — Clone any GitHub repo

```zsh
gcg "user/repo"  # → git clone "gh:user/repo" (gh: → git@github.com:)
```

### `glg` — Pretty log

Alias in `aliases.sh`: `git log --all --graph --pretty=format:'%C(magenta)%h …'`.

### `getVersion <repo> [all]`

```zsh
getVersion "owner/repo"        # → latest tag via GitHub API + jq .tag_name
getVersion "owner/repo" all    # → gh release list -R owner/repo --limit 100
```

Uses `curl -fsSL https://api.github.com/repos/$repo/releases/latest` or `gh`.

---

## Development

### `cr [args]` / `ccr [args]` — Cargo run quiet

```zsh
cr    # cargo run --quiet "$@" || true
ccr   # clear; cargo run --quiet "$@" || true
```

### `vite [dir]` — Vite dev server with cleanup

Runs `vite --config "$XDG_CONFIG_HOME/vite/vite.config.js"`; traps `INT` to log, then offers to remove `dir/.vite` via `gum confirm`.

### `bashc [cmd]` — Execute bash from input

```zsh
bashc "echo hi"   # uses $* as input
bashc             # prompts via gum write
# copies input to clipboard, then bash -c "$input"
```

### `fd [args]` — fd wrapper

Prefers `fd.sh` alternative if present:

```zsh
fd() { command -v fd.sh &>/dev/null && command fd.sh "$@" || command fd "$@"; }
```

---

## AI — tgpt wrappers

Underlying `tgpt()` prompts via `gum write` if no args: `command tgpt "$(gum write …)"`.

| Function | Call | Provider | Description |
|----------|------|----------|-------------|
| `t-sh` | `tgpt --shell` | default | Describe → generate & execute shell command |
| `t-code` | `tgpt --code` | phind | Describe → generate code/script |
| `t-img` | `tgpt --image --out <file>` | pollinations | Describe → image (asks filename via `gum input`, default `output.jpg`) |
| `t-search` | `tgpt --provider isou` | isou | Web search / research |
| `t-chat` | `tgpt --multiline` | phind | Persistent interactive chat |

### `ai` — Unified launcher

```zsh
ai  # gum choose → Shell / Code / Search / Chat / Image / Exit
```

---

## Utilities

### `help [topic]`

```zsh
help() { bash -c "help $*" | bathelp --pager=none --; }
```

Bash builtin help → `bat`.

### `which [cmd…]` — Enhanced which

Merges aliases + functions into GNU `which`:

```zsh
which() {
  (alias; declare -f) | /usr/bin/which --tty-only --read-alias --read-functions --show-tilde --show-dot "$@" | shellfmt
}
```

### `calc [expr]` / `qalc [expr]`

```zsh
calc "2 + 2"   # qalc --base 10 --color --terse
qalc "2 + 2"   # qalc --base 10 --color
# no arg → prompts via gum input
```

### `ffprobe [file]`

```zsh
ffprobe video.mp4  # ffprobe -v error -select_streams v:0 -show_entries stream=codec_name,width,height,avg_frame_rate,bit_rate
```

### `touch <path…>` — mkdir + touch

Creates parent dirs via `mkdir -p "$(dirname "$file")"` before `command touch`.

### `bat [file…]` — Smart bat pager

Heuristic: if `sum(lines) *100 > (COLUMNS/2)*100` → adds `--pager=builtin` to `bat --paging=auto --style=plain --color=auto`.

### `bathelp [args]` — Help language

```zsh
bathelp() { command bat --language=help --style=plain --color=auto "$@"; }
```

### `rename [args]` — Perl rename

Prefers `/usr/bin/vendor_perl/rename` or `perl-rename`:

```zsh
rename 's/foo/bar/' *.txt
```

### `copypath [path=. ]`

Resolves absolute path (`realpath` → `readlink -f` → `cd+pwd -P` fallback), `collapseTilde`, `clipcopy`, echoes confirmation.

### `du-dir <dir>` / `du <path>` — Disk usage sorted

```zsh
du-dir /var   # sudo sh -c "du -h -d1 /var" | sort -hr
du /var/log   # sudo sh -c "du -h /var/log" | sort -hr
```

### `pdf2png <file.pdf>`

```zsh
pdf2png doc.pdf  # pdftocairo -png -r 300 doc.pdf doc
```

### `gif <image>` — Kitty image display

```zsh
gif image.png  # kitty +kitten icat
```

### `advrm <dir>` — Progress rm

```zsh
advrm ./big-dir  # counts files/dirs, pv -0 -l -s $total_files | xargs -0 rm -f, rm -rf dir
```

---

## Autoloadable

### `functions/edit-command-line-sh`

ZLE widget (see `keybindings.md`): edits `$BUFFER`/`$PREBUFFER`/visual/line selection in `$VISUAL`/`$EDITOR`, placing cursor correctly for vim (`byteoffset`) vs emacs (`+line:col`), handling multi-line PS2 buffers and bracketed paste. Bound to `Ctrl+X Ctrl+E`.
