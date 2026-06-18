# Zsh Configuration

A modular, XDG-compliant Zsh setup managed via [Tuckr](https://github.com/RaphGL/Tuckr) dotfiles and powered by [Zinit](https://github.com/zdharma-continuum/zinit) plugin manager.

## Architecture

```
~/.config/zsh/
├── .zshenv          # Environment variables, PATH, XDG dirs (loaded always)
├── .zprofile        # Login shell placeholder (SSH/TTY only)
├── .zshrc           # Main entry point: interactive guard, bootstrap, module loading
├── .shellcheckrc    # ShellCheck linter configuration
│
├── variables.sh     # Env vars, PATH construction, tool configs (loaded 1st)
├── options.sh       # setopt / unsetopt (loaded 2nd)
├── functions.sh     # Custom shell functions (loaded 3rd)
├── plugins.sh       # Zinit + OMZ snippets (loaded 4th)
├── keybinds.sh      # ZLE widget key bindings (loaded 5th)
├── completion.sh    # compinit, zstyle, fzf-tab (loaded 6th)
├── history.sh       # History options & dedup (loaded 7th)
├── hooks.sh         # precmd/preexec/chpwd hooks (loaded 8th)
├── aliases.sh       # Aliases, suffix/global aliases (loaded 9th)
├── secrets.sh       # API keys from pass (loaded last)
│
├── apps/            # Per-application configs loaded after modules
├── functions/       # FPATH directories for autoloadable functions
└── completions/     # Custom completion definitions (e.g. _mise)
```

### Loading Order

`.zshrc` sources modules in strict order — dependencies are respected:

1. **variables.sh** — must be first (defines `$PATH`, `$XDG_*`, all tool env vars)
2. **options.sh** — zsh options
3. **functions.sh** — reusable shell functions (may use env vars)
4. **plugins.sh** — zinit init, OMZ snippets, autoloads (may define aliases)
5. **keybinds.sh** — key bindings (some depend on ZLE widgets from plugins)
6. **completion.sh** — compinit, zstyle, fzf-tab (after plugins since they register completions)
7. **history.sh** — history settings
8. **hooks.sh** — precmd/preexec/chpwd hooks
9. **aliases.sh** — **must be late** to override OMZ defaults
10. **secrets.sh** — last, since it depends on env vars and `pass`
11. **apps/\*.sh** — per-app configs loaded last

### Entry Points

| File | When Loaded | Purpose |
|------|-------------|---------|
| `.zshenv` | Every shell invocation | XDG dirs, `$ZDOTDIR`, `$PATH`, `$FPATH`, editor/browser detection, GPG |
| `.zprofile` | Login shells only | Placeholder for SSH/TTY sessions |
| `.zshrc` | Interactive shells only | Main entry point with interactive guard |

## Key Design Decisions

- **XDG Base Directory** — All config, cache, data, and state dirs follow the standard
- **Zinit plugin manager** — Lazy-loading, turbo mode, annexes for Rust/npm/gem builds
- **Starship prompt** — Fast, customizable cross-shell prompt
- **Transient prompt** — Prompt collapses to a single `❯`/`✗` after command execution
- **fzf-tab** — fzf-powered tab completion with file previews via `eza`
- **helix-zsh** — Helix-style modal keybindings via Rust driver (hxcmd/hxins/hxsel)
- **pass** — GPG-encrypted password store for API keys (never plaintext in config)
- **No Oh My Zsh** — Uses individual OMZ snippets instead (lighter weight)
- **ShellCheck validated** — `.shellcheckrc` enforces strict linting

## Tool Replacements

| Original | Replacement | Description |
|----------|-------------|-------------|
| `cat` | `bat` | Syntax-highlighted pager |
| `cd` | `zoxide` (via `z`) | Frecency-based directory jumper |
| `ls` | `eza` | Icons, colors, git-aware listing |
| `grep` | `ripgrep` | Blazingly fast recursive search |
| `rm` | `trash-cli` | Safe deletion (trash bin) |
| `rmdir` | `trash-cli` | Safe directory deletion |
| `cp` | `advcp` | Progress bar on copy |
| `mv` | `advmv` | Progress bar on move |
| `nano` | `micro` | Modern terminal editor |
| `diff` | diff with `--color=auto` | Colorized diff output |

## Quick Reference

```bash
# Reload config
reload

# Edit config
zshrc

# Copy current directory path
pwdcp

# List directory tree (excluding noise dirs)
lst

# Fuzzy file finder
Ctrl+T

# Directory history navigation
Alt+Left / Alt+Right

# Undo / Redo
Ctrl+Z / Ctrl+Y

# Copy current buffer
Ctrl+O

# Edit command in $EDITOR
Ctrl+X Ctrl+E
```
