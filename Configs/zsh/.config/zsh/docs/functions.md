# Custom Functions Reference

## File Navigation

### `yy` — Yazi file manager with directory tracking

Opens [Yazi](https://yazi-rs.github.io) and changes shell directory to wherever Yazi navigated to.

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

### `dotfiles` — Browse dotfiles via Yazi

Opens dotfiles directory in Yazi with an interactive selector.

```zsh
dotfiles() {
  oldDir="${PWD}"
  target=$(dotfiles.sh "$1") || { eraseLine; log-info "Nothing selected"; return 0 }
  yy "${target}"
  [[ "${oldDir}" != "${PWD}" ]] && log-info "Changed directory!"
}
```

### `ls` / `lsu` / `lst` / `lstu` — Eza wrappers

Enhanced `ls` using `eza` with icons, colors, long format. Falls back gracefully when `--total-size` times out.

| Function | Description |
|----------|-------------|
| `ls` | Standard listing with total-size (3s timeout) |
| `lsu` | Root listing via `sudo -A` (5s timeout) |
| `lst` | Tree view (excludes `node_modules`, `.turbo`, `dist`, etc.) |
| `lstu` | Root tree view via `sudo -A` |

Common flags: `--all`, `--color=auto`, `--long`, `--icons`, `--no-time`, `--no-user`, `--sort=name`, `--group-directories-first`

## Git

### `gcm` — Clone from personal GitHub

Resolves to `git clone git@github.com:AhmedOsman101/`

```zsh
gcm "repo-name"  # clones git@github.com:AhmedOsman101/repo-name
```

### `gcg` — Clone any GitHub repo

Resolves to `git clone git@github.com:`

```zsh
gcg "user/repo"  # clones git@github.com:user/repo
```

### `glg` — Pretty git log

Alias defined in aliases.sh showing colorful graph with author, relative time, and refs.

## Development

### `cr` / `ccr` — Cargo run shortcuts

```zsh
cr       # cargo run --quiet
ccr      # clear + cargo run --quiet
```

### `vite` — Vite dev server with cleanup

Runs Vite with custom config path. On interrupt, offers to clean up `.vite` cache directories.

```zsh
vite                  # Runs with ~/.config/vite/vite.config.js
vite my-project       # Cleans up my-project/.vite on exit
```

### `bashc` — Execute bash from input

Takes inline input or prompts via `gum write`, copies to clipboard, then executes.

## AI Assistant (tgpt wrappers)

Five modes wrapping [tgpt](https://github.com/aandrew-me/tgpt):

| Function | Mode | Provider | Description |
|----------|------|----------|-------------|
| `t-sh` | Shell `(-s)` | Default | Generate & execute shell commands |
| `t-code` | Code `(-c)` | phind | Generate code/scripts |
| `t-img` | Image `(-img)` | pollinations | Generate images |
| `t-search` | Search | isou | Web search / research |
| `t-chat` | Interactive `(-m)` | phind | Persistent chat session |

### `ai` — Unified AI launcher

Interactive menu using `gum choose` to select one of the five modes above.

## Utilities

### `help` — Help with bat pager

```zsh
help() { bash -c "help $*" | bathelp --pager=none -- }
```

### `which` — Enhanced which

Shows alias definitions, function source, and pipes through `shellfmt`:

```zsh
which() {
  (alias; declare -f) | /usr/bin/which --tty-only --read-alias --read-functions \
    --show-tilde --show-dot "$@" | shellfmt 2>/dev/null
}
```

### `calc` / `qalc` — Qalculate calculator

```zsh
calc "2 + 2"    # Terse mode
qalc "2 + 2"    # Verbose mode
```

Accepts argument or prompts via `gum input`.

### `ffprobe` — Quick media info

Shows codec, resolution, framerate, bitrate for video streams. Suppresses all ffprobe noise.

### `touch` — mkdir + touch

Creates parent directories automatically when touching nested paths.

### `bat` — Smart bat pager

Auto-switches between paging modes based on file size vs terminal width. Uses `builtin cd` to avoid triggering chpwd hooks.

### `bathelp` — Help text with bat

Renders help text using bat with the `help` language definition.

### `rename` — Perl rename wrapper

Prefers `/usr/bin/vendor_perl/rename` or `perl-rename` (perl-based regex renaming) over basic `rename`.

### `copypath` — Copy file path to clipboard

Resolves absolute path (via `realpath`, `readlink`, or fallback), collapses tilde, copies via `clipcopy`, and echoes confirmation.

### `du` / `du-dir` — Disk usage with sudo

```zsh
du-dir /var    # du -h -d1 /var | sort -hr
du /var/log    # du -h /var/log | sort -hr
```

### `pdf2png` — PDF to PNG conversion

```zsh
pdf2png document.pdf  # Creates document-1.png, document-2.png, etc.
```

### `gif` — Display image in kitty terminal

```zsh
gif image.png  # Shows image via kitty +kitten icat
```

### `advrm` — Advanced rm with progress

```zsh
advrm /path/to/dir  # Counts files/dirs, shows progress bar via pv, then removes
```

## File Operations

### `fd` — fd wrapper

Prefer `fd.sh` (fd alternative) if available, otherwise use standard `fd`.
