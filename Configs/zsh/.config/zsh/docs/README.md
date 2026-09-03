# Zsh Configuration

A modular, XDG-compliant Zsh setup managed via [Tuckr](https://github.com/RaphGL/Tuckr) and powered by [Zinit](https://github.com/zdharma-continuum/zinit). Fast startup, strict ordering, and per-app shims.

## How It Flows

```
Shell start
  │
  ├─ .zshenv  (always: every zsh, even non-interactive)
  │     ├─ Exports XDG dirs (CONFIG/CACHE/DATA/STATE)
  │     ├─ ZINIT_HOME, ZDOTDIR, ZSHRC, SCRIPTS_DIR
  │     ├─ TUCKR vars (TUCKR_HOME/DIR/TARGET)
  │     ├─ DEVICE via hostnamectl, EDITOR/BROWSER auto-detect
  │     ├─ GPG_TTY, HISTDB_FILE, CHROME/PUPPETEER paths
  │     ├─ XONSH_HOME, PATH += SCRIPTS_DIR:.local/bin:xonsh/xbin
  │     └─ FPATH += ZDOTDIR/functions
  │
  ├─ .zprofile  (login shells only — SSH/TTY)
  │     └─ Placeholder; no logic by design (interactive config lives in .zshrc)
  │
  └─ .zshrc  (interactive shells only: [[ -o interactive ]] || return)
        ├─ Concurrency guard: source lock.sh → _zshrc_lock_acquire (flock → zsystem → mkdir)
        │     └─ Held ONLY for .zshrc sourcing; released before tmux autostart
        ├─ Bootstrap Zinit (clone if missing, source zinit.zsh, autoload _zinit)
        ├─ Load modules IN ORDER (strict dependencies):
        │     1. variables.sh  — env, XDG, PATH, FZF/GUM/LS_COLORS (must be first)
        │     2. options.sh    — setopt extendedglob, AUTO_CD, unsetopt nomatch
        │     3. functions.sh  — reusable shell functions (yy, ls, bat, tgpt, …)
        │     4. plugins.sh    — starship, zinit lights, annexes, OMZ snippets, hooks
        │     5. keybinds.sh   — ZLE bindings (emacs keymap, ctrl_l/copybuffer/…)
        │     6. completion.sh — compinit, zstyle, fzf-tab, ftc, region-highlight
        │     7. history.sh    — HISTSIZE/SAVEHIST/HISTFILE + dedup options
        │     8. hooks.sh      — precmd rehash, chpwd python-venv, path hook
        │     9. aliases.sh    — aliases + suffix (-s) + global (-g) (must be late)
        │    10. secrets.sh    — GPG `pass` → API keys (must be last)
        │
        ├─ Load apps/*.sh loop (per-tool completions & env; see apps.md)
        │     Active: atuin, bun, cargo, curlie, delta, deno, fzf, micromamba,
        │             mise, omp, opencode, php-cs-fixer, pnpm, podman,
        │             transient-prompt, uv, zoxide
        │     Disabled: fuck.sh.disabled, helix-zsh.sh.disabled
        │
        ├─ Release lock: _zshrc_lock_release (before tmux so next queued shell proceeds)
        ├─ Cleanup (unset MODULES/module/app)
        └─ Auto-start tmux if not already running (tmux ls || tmux)
              └─ Separate: autostart.sh (X11/DBus, copyq/ollama/sxhkd/9router/omniroute)
```

### Entry Points

| File | When | Purpose |
|------|------|---------|
| `.zshenv` | Every invocation | XDG dirs, `ZDOTDIR`, `PATH`/`FPATH`, editor/browser probe, `GPG_TTY`, `HISTDB_FILE`, Chrome/Xonsh paths |
| `.zprofile` | Login shells only | Intentionally empty — SSH/TTY sessions; interactive setup stays in `.zshrc` |
| `.zshrc` | Interactive only | Interactive guard → concurrency lock → zinit bootstrap → ordered modules → `apps/*.sh` → release lock → `tmux` |
| `lock.sh` | Sourced at top of `.zshrc` | Serializes parallel restores (tmux-resurrect/continuum) via `flock` → `zsystem` → `mkdir` |
| `autostart.sh` | Manual / WM autostart | Kills stale daemons, disables DPMS, starts copyq/ollama/sxhkd/dbus/9router/omniroute |

### Filesystem Layout

```
~/.config/zsh/
├── .zshenv              # Always-loaded env
├── .zprofile            # Login placeholder
├── .zshrc               # Interactive entry point + loader
├── lock.sh              # Concurrency guard (flock/zsystem/mkdir)
├── .shellcheckrc        # ShellCheck rules
│
├── variables.sh         # Env vars, PATH, FZF/GUM/LS_COLORS (1st)
├── options.sh           # setopt/unsetopt (2nd)
├── functions.sh         # Shell functions (3rd)
├── plugins.sh           # Zinit + annexes + OMZ snippets (4th)
├── keybinds.sh          # ZLE (emacs) bindings (5th)
├── completion.sh        # compinit + fzf-tab (6th)
├── history.sh           # History opts + dedup (7th)
├── hooks.sh             # precmd/chpwd hooks (8th)
├── aliases.sh           # Aliases -s/-g (9th, late to override OMZ)
├── secrets.sh           # pass → keys (10th, last)
│
├── autostart.sh         # Desktop session daemons (standalone)
├── apps/                # Per-app shims loaded after modules
│   ├── *.sh             # Active (see apps.md)
│   └── *.sh.disabled    # Disabled: fuck, helix-zsh
├── functions/           # FPATH autoloads (edit-command-line-sh)
├── completions/         # Custom completions (_mise)
└── docs/                # This documentation
```

## Key Design Decisions

- **XDG Base Directory** — Every tool forced XDG-compliant via env vars in `variables.sh` (Cargo, Go, NVM, Docker, Android SDK, asdf, …).
- **Zinit plugin manager** — Lazy lights + 4 annexes (as-monitor, bin-gem-node, patch-dl, rust); Starship installed via zinit fallback if not on system.
- **Concurrency guard** — `lock.sh` serializes parallel `.zshrc` sourcing (tmux continuum restores N panes → N races). Uses `flock` (external, per-FD, kernel-queued) → `zsystem flock` (fallback) → `mkdir` spin with TTL. Held only for `.zshrc` duration, released before `tmux ls`. Idempotent, re-entrant (`reload` safe), stale-safe, `ZSHRC_LOCK_TIMEOUT=60` override, `ZSHRC_LOCK_DEBUG=1` verbose.
- **No Oh My Zsh framework** — Individual OMZ snippets via `zinit snippet OMZP::…` (lighter, 11 active + 2 commented).
- **Starship + transient-prompt** — Full 2-line Starship while typing; collapses to `❯` (green) / `✗` (red) after execution via `transient-prompt.sh` in `apps/`.
- **fzf-tab** — Replaces zsh completion menu; previews via `eza`.
- **Emacs keymap** — `bindkey -e` (not vi). ZVM disabled (`jeffreytse/zsh-vi-mode` commented in `plugins.sh`; `zvm_config()` defined then `unset -f`). Previous ZVM config preserved in `keybinds.sh.bak` and `apps/helix-zsh.sh.disabled`.
- **pass** — GPG-encrypted secret store; `secrets.sh` short-circuits if all vars already set.
- **tmux autostart** — Every interactive shell runs `tmux ls || tmux` at end of `.zshrc` (after lock release so next queued shell can proceed immediately).
- **ShellCheck validated** — `.shellcheckrc` enforces linting.

## Tool Replacements

| Original | Replacement | Notes |
|----------|-------------|-------|
| `cat` | `bat --paging=never --style=plain` | Via alias + smart `bat()` wrapper |
| `cd` | `zoxide` (`z`) | `alias cd=z` + `zoxide init zsh` |
| `ls` | `eza` | Wrappers: `ls`/`lsu`/`lst`/`lstu` with `--total-size` timeout fallback |
| `grep` / `rg` | `rg -iNL` | `alias grep="command rg -iNL"` |
| `rm` / `rmdir` | `trash-cli` | `rmtrash` / `rmdirtrash` |
| `cp` / `mv` | `advcp` / `advmv` | `alias cp='advcp -ivg'` |
| `nano` | `micro` | `alias nano=micro` |
| `diff` | `diff -u --color=auto` | Colorized unified diff |
| `man` | `bat --language=man` | `MANPAGER="col -bx | bat …"` |
| `which` | `which()` function | Merges `alias`+`declare -f` → `shellfmt` |
| `touch` | `touch()` function | Auto `mkdir -p` parents |

## Quick Reference

```bash
reload              # source "$ZSHRC" (re-loads all modules + apps)
zshrc               # $EDITOR "$ZSHRC"
pwdcp               # collapseTilde "$PWD" | clipcopy
paths               # printenv PATH | tr : \\n | collapseTilde | no-dups | sort
lst / lstu          # tree view (lstu via sudo -A)
yy [dir]            # yazi with cwd tracking
dotfiles [filter]   # browse dotfiles via yazi
Ctrl+T              # fzf file finder (fd-backed)
Alt+Left / Alt+Right# dirhistory (OMZ) — prev/next dir
Ctrl+Z / Ctrl+Y     # undo / redo
Ctrl+O              # copybuffer → clipcopy
Ctrl+X Ctrl+E       # edit-command-line-sh → $EDITOR (vim byte-offset / emacs line)
Shift+Tab           # magic-space (history expansion)
Ctrl+L              # ctrl_l — clear without scrollback + reset-prompt
ZSHRC_LOCK_DEBUG=1 zsh -i -c 'echo hi'  # debug lock acquisition
```
