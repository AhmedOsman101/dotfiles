# Aliases Reference

## File & Navigation

| Alias | Command | Description |
|-------|---------|-------------|
| `cd` | `z` | Zoxide directory jumper |
| `cdroot` | `cd "$(git-root)"` | Jump to git root |
| `cls` | `clear` | Clear screen |
| `pwdcp` | `collapseTilde "$PWD" \| clipcopy` | Copy current path to clipboard |
| `paths` | `printenv PATH \| tr ":" "\n" \| collapseTilde \| no-dups \| sort` | List PATH entries |

## Tool Replacements

| Alias | Command | Description |
|-------|---------|-------------|
| `cat` | `bat --paging=never --style=plain --color=auto` | Syntax-highlighted cat |
| `catwhich` | `batwhich` | Bat-powered which |
| `grep` | `rg -iNL` | Ripgrep with case-insensitive, no-line-number, no-filename |
| `rg` | `rg -iNL` | Same as grep |
| `ls` | custom `eza` wrapper | Icons, long format, colors |
| `nano` | `micro` | Modern editor |
| `mc` | `micro` | Same |
| `diff` | `diff -u --color=auto` | Colorized unified diff |
| `type` | `type -a` | All definitions of a command |
| `less` | `less -RFX` | Raw control chars, quit at EOF, no clearing |
| `open` | `xdg-open` | Default system opener |

## File Operations

| Alias | Command | Description |
|-------|---------|-------------|
| `rm` | `rmtrash` | Trash instead of delete |
| `rmdir` | `rmdirtrash --ignore-fail-on-non-empty` | Trash directory |
| `cp` | `advcp -ivg` | Progress bar, interactive, verbose |
| `mv` | `advmv -ivg` | Progress bar, interactive, verbose |

## Disk & System

| Alias | Command | Description |
|-------|---------|-------------|
| `df` | `df -h` | Human-readable disk usage |
| `dus` | `du -sh` | Summary disk usage |
| `free` | `free -m` | Memory in MB |
| `psmem` | `n "ps \| sort-by mem -r \| first 5"` | Top 5 memory processes (nushell) |
| `pscpu` | `n "ps \| sort-by cpu -r \| first 5"` | Top 5 CPU processes (nushell) |
| `code-stats` | `tokei` | Codebase statistics |
| `getgpu` | `lspci -k -d ::03xx` | GPU info |

## Git

| Alias | Command | Description |
|-------|---------|-------------|
| `git-init` | `git init && git add -A && git commit -m "initial commit"` | Quick init |
| `first-commit` | `git log --oneline \| tail -1` | Show first commit |
| `gca` | `git-commit --ai` | Commit all with AI-generated message |
| `glg` | `git log --all --graph --pretty=...` | Pretty git log |
| `gc` | `git clone` | Clone |
| `glc` | `git pull origin $(git_current_branch)` | Pull current branch |
| `glo` | `git pull origin` | Pull origin |
| `gi` | `mk-gitignore` | Generate gitignore |
| `lzg` | `lazygit` | TUI git client |
| `sw` | `switch-branch` | Interactive branch switcher |

## Development

| Alias | Command | Description |
|-------|---------|-------------|
| `art` | `php artisan` | Laravel artisan |
| `sail` | `sh $([ -f sail ] && echo sail \|\| echo vendor/bin/sail)` | Laravel Sail |
| `cb` | `cargo build` | Rust build |
| `pnpx` / `npx` | `pnpm dlx` | Execute from registry |
| `stdver` | `standard-version` | Semantic versioning |
| `rp` | `release-please` | Release automation |
| `python` | `python3` | Python 3 |
| `pip` | `pip3` | Pip 3 |

## System Administration

| Alias | Command | Description |
|-------|---------|-------------|
| `goodnight` | `sync && sudo systemctl poweroff` | Safe shutdown |
| `goodnights` | `SUDO_ASKPASS=... sudo -A sync && sudo -A systemctl poweroff` | Safe shutdown (askpass) |
| `restart` | `sync && sudo systemctl reboot` | Safe reboot |
| `restarts` | `SUDO_ASKPASS=... sudo -A sync && sudo -A systemctl reboot` | Safe reboot (askpass) |
| `freepacman` | `sudo rm /var/lib/pacman/db.lck` | Unlock pacman |
| `mirror` | `sudo reflector --save /etc/pacman.d/mirrorlist ...` | Fastest Arch mirrors |
| `doas` | `doas --` | Safer sudo alternative |
| `caps` | `xdotool key Caps_Lock` | Toggle capslock |

## Networking

| Alias | Command | Description |
|-------|---------|-------------|
| `frg` | `frogmouth` | Markdown preview |
| `mancat` | `man --pager="bat ... --language=man"` | Man pages with bat |
| `ffmpeg` | `ffmpeg -hide_banner` | FFmpeg (clean output) |
| `wget` | `wget --hsts-file="$XDG_DATA_HOME/wget-hsts"` | XDG-compliant wget |
| `yless` / `jless` | `jless --yaml` | YAML/JSON pager |
| `adb` | `HOME="${XDG_DATA_HOME}/android" adb` | XDG-compliant ADB |
| `svn` | `svn --config-dir "${XDG_CONFIG_HOME}/subversion"` | XDG-compliant SVN |
| `conky` | `conky --config="$XDG_CONFIG_HOME/conky/conkyrc"` | XDG-compliant Conky |
| `nvidia-settings` | `nvidia-settings --config="${XDG_CONFIG_HOME}/nvidia/settings"` | XDG-compliant nvidia |
| `reload-sxhkd` | `pkill -USR1 -x sxhkd` | Reload hotkeys |
| `lorem` | `shlorem` | Lorem ipsum generator |

## Docker

| Alias | Command | Description |
|-------|---------|-------------|
| `dbox` | `distrobox` | Distrobox manager |
| `mysql` | `mariadb` | MariaDB alias |

## Utilities

| Alias | Command | Description |
|-------|---------|-------------|
| `zshrc` | `${EDITOR} "${ZSHRC}"` | Edit zsh config |
| `bashrc` | `${EDITOR} "${HOME}/.bashrc"` | Edit bash config |
| `reload` | `source "${ZSHRC}"` | Reload config |
| `help` | custom function | Help with bat pager |
| `task` / `mask` | `command mask` / `mask --maskfile ...` | Task runner |
| `code-stats` | `tokei` | Code statistics |

## Suffix Aliases (open file types with specific programs)

| Suffix | Program |
|--------|---------|
| `.json` | `jless` |
| `.yml` | `yless` (jless --yaml) |
| `.yaml` | `yless` |
| `.md` | `frogmouth` |

## Global Aliases (usable anywhere in command line)

| Alias | Expansion | Description |
|-------|-----------|-------------|
| `H` | `--help 2>&1 \| command bat --language=help --style=plain --color=auto` | Help via bat |
| `NE` | `2>/dev/null` | Suppress stderr |
| `NO` | `>/dev/null` | Suppress stdout |
| `NUL` | `&>/dev/null` | Suppress all output |
| `C` | `\| clipcopy` | Pipe to clipboard |
| `L` | `\| less` | Pipe to less |
| `J` | `\| jq .` | Pretty-print JSON |
| `JL` | `\| jless` | Pipe to jless pager |

## Overrides (removed OMZ defaults)

```bash
unalias g       # OMZ 'g' alias (git shorthand)
unalias gcm     # OMZ 'gcm' alias (git checkout master)
unalias zi      # zinit alias clash
```
