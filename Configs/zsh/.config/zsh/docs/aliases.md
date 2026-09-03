# Aliases Reference

Source: `aliases.sh` (loaded 9th in `.zshrc` — late to override OMZ). Suffix (`-s`) and global (`-g`) aliases at the end, with `unalias g/gcm/zi` cleanup.

## File & Navigation

| Alias | Command | Description |
|-------|---------|-------------|
| `cd` | `z` | Zoxide frecency jumper |
| `cdroot` | `cd "$(git-root)"` | Jump to git worktree root |
| `cls` | `clear` | Clear screen |
| `pwdcp` | `collapseTilde "$PWD" \| clipcopy` | Copy collapsed cwd |
| `paths` | `printenv PATH \| tr ":" "\n" \| collapseTilde \| no-dups \| sort` | Sorted unique PATH |
| `mkdir` | `mkdir -pv` | Always create parents, verbose |

## Tool Replacements

| Alias | Command | Description |
|-------|---------|-------------|
| `cat` | `bat --paging=never --style=plain --color=auto` | Syntax-highlighted cat |
| `catwhich` | `batwhich` | Bat-powered which |
| `grep` | `rg -iNL` | Ripgrep (ignore-case, no line/filename) |
| `rg` | `rg -iNL` | Same |
| `ls` | `ls()` function → `eza` | Icons, long, colors (see functions.md) |
| `nano` / `mc` | `micro` | Modern editor |
| `diff` | `diff -u --color=auto` | Unified color diff |
| `type` | `type -a` | All definitions |
| `less` | `less -RFX` | Raw, quit at EOF, no clear |
| `open` | `xdg-open` | System opener |
| `which` | `which()` function | Alias+function-aware → shellfmt |

## File Operations

| Alias | Command | Description |
|-------|---------|-------------|
| `rm` | `rmtrash` | Trash (safe delete) |
| `rmdir` | `rmdirtrash --ignore-fail-on-non-empty` | Trash dir |
| `cp` | `advcp -ivg` | Copy with progress |
| `mv` | `advmv -ivg` | Move with progress |

## Disk & System

| Alias | Command | Description |
|-------|---------|-------------|
| `df` | `df -h` | Human-readable |
| `dus` | `du -sh` | Summary |
| `free` | `free -m` | MB |
| `psmem` | `n "ps \| sort-by mem -r \| first 5"` | Top 5 mem (nushell) |
| `pscpu` | `n "ps \| sort-by cpu -r \| first 5"` | Top 5 CPU (nushell) |
| `code-stats` | `tokei` | Code stats |
| `getgpu` | `lspci -k -d ::03xx` | VGA/GPU info |
| `du-dir` / `du` | `du()` functions | `du -h -d1` sorted (via sudo) |

## Git

| Alias | Command | Description |
|-------|---------|-------------|
| `git-init` | `git init && git add -A && git commit -m "initial commit"` | Quick init |
| `first-commit` | `git log --oneline \| tail -1 \| awk '{print $1}'` | First commit hash |
| `gca` | `git-commit --ai` | AI commit message |
| `glg` | `git log --all --graph --pretty=format:'%C(magenta)%h…'` | Pretty graph log |
| `gc` | `git clone` | Shorthand |
| `glc` | `git pull origin $(git_current_branch)` | Pull current branch |
| `glo` | `git pull origin` | Pull origin |
| `gi` | `mk-gitignore` | Generate gitignore |
| `lzg` | `lazygit` | TUI |
| `sw` | `switch-branch` | Interactive branch switcher |

> OMZ `g`/`gcm` removed via `unalias g/gcm` at EOF.

## Development

| Alias | Command | Description |
|-------|---------|-------------|
| `art` | `php artisan` | Laravel |
| `sail` | `sh $([ -f sail ] && echo sail \|\| echo vendor/bin/sail)` | Laravel Sail |
| `cb` | `cargo build` | Rust build |
| `cr` / `ccr` | `cr()`/`ccr()` functions | `cargo run --quiet` (ccr clears first) |
| `pnpx` / `npx` | `pnpm dlx` | Exec from registry |
| `stdver` | `standard-version` | Semver |
| `rp` | `release-please` | Release automation |
| `python` | `python3` | Alias |
| `pip` | `pip3` | Alias |
| `dsh` | `bunx @deepseek-ai/dsh` | DeepSeek harness |

## Task Runner

```zsh
if command -v mask &>/dev/null; then
  unalias mask &>/dev/null
  alias task='command mask'
  alias mask='mask --maskfile "$(git-root 2>/dev/null || pwd)/maskfile.md"'
fi
```

`mask` resolves to repo-root `maskfile.md`; `task` is the unaliased `mask`.

## System / Admin

| Alias | Command | Description |
|-------|---------|-------------|
| `goodnight` | `sync && sudo systemctl poweroff` | Safe shutdown |
| `goodnights` | `SUDO_ASKPASS=… sudo -A sync && sudo -A systemctl poweroff` | Shutdown via askpass |
| `restart` | `sync && sudo systemctl reboot` | Safe reboot |
| `restarts` | `SUDO_ASKPASS=… sudo -A sync && SUDO_ASKPASS=… sudo -A systemctl reboot` | Reboot via askpass |
| `freepacman` | `sudo rm /var/lib/pacman/db.lck &>/dev/null \|\| true` | Unlock pacman |
| `mirror` | `sudo reflector --save /etc/pacman.d/mirrorlist --protocol https --country TR,GR,IT,SA,IL,DE --latest 15 --sort rate` | Fastest mirrors |
| `doas` | `doas --` | Pass-through (safer sudo) |
| `caps` / `CAPS` | `xdotool key Caps_Lock` | Toggle capslock |

## Media & Paging

| Alias | Command | Description |
|-------|---------|-------------|
| `frg` | `frogmouth` | Markdown preview |
| `mancat` | `man --pager="bat --paging=never … --language=man"` | Man via bat |
| `ffmpeg` | `ffmpeg -hide_banner` | Clean output |
| `yless` | `jless --yaml` | YAML pager |
| `jless` | (binary) | JSON/YAML pager |
| `lorem` | `shlorem` | Lorem generator |

## XDG Wrappers

| Alias | Command | Description |
|-------|---------|-------------|
| `wget` | `wget --hsts-file="$XDG_DATA_HOME/wget-hsts"` | XDG hsts |
| `adb` | `HOME="$XDG_DATA_HOME/android" adb` | XDG android home |
| `svn` | `svn --config-dir "$XDG_CONFIG_HOME/subversion"` | XDG svn |
| `conky` | `conky --config="$XDG_CONFIG_HOME/conky/conkyrc"` | XDG config |
| `nvidia-settings` | `nvidia-settings --config="$XDG_CONFIG_HOME/nvidia/settings"` | XDG config |

## Misc

| Alias | Command | Description |
|-------|---------|-------------|
| `zshrc` | `${EDITOR} "${ZSHRC}"` | Edit zsh config |
| `bashrc` | `${EDITOR} "${HOME}/.bashrc"` | Edit bash config |
| `reload` | `source "${ZSHRC}"` | Reload config |
| `help` | `help()` function | `bash -c "help $*" \| bathelp` |
| `dbox` | `distrobox` | Container manager |
| `mysql` | `mariadb` | Alias |
| `reload-sxhkd` | `pkill -USR1 -x sxhkd` | Reload hotkeys |

## Suffix Aliases (`-s`)

Typing a filename with these extensions executes the right-hand side:

| Suffix | Command |
|--------|---------|
| `.json` | `jless` |
| `.yml` | `yless` (`jless --yaml`) |
| `.yaml` | `yless` |
| `.md` | `frogmouth` |

## Global Aliases (`-g` — usable anywhere in a pipeline)

| Alias | Expansion | Example |
|-------|-----------|---------|
| `H` | `--help 2>&1 \| command bat --language=help --style=plain --color=auto` | `cmd H` |
| `NE` | `2>/dev/null` | `cmd NE` |
| `NO` | `>/dev/null` | `cmd NO` |
| `NUL` | `&>/dev/null` | `cmd NUL` |
| `C` | `\| clipcopy` | `echo hi C` |
| `L` | `\| less` | `ps aux L` |
| `J` | `\| jq .` | `curl … J` |
| `JL` | `\| jless` | `curl … JL` |

## Overrides Removed

```bash
unalias g   &>/dev/null || true   # OMZ 'g' (git)
unalias gcm &>/dev/null || true   # OMZ 'gcm' (git checkout master)
unalias zi  &>/dev/null || true   # zinit/zsh-you-should-use clash
```
