# Module Reference

## variables.sh

Path construction and environment variables for every tool.

### XDG Directories

```bash
XDG_CONFIG_HOME="$HOME/.config"
XDG_CACHE_HOME="$HOME/.cache"
XDG_DATA_HOME="$HOME/.local/share"
XDG_STATE_HOME="$HOME/.local/state"
```

### Tool Configurations

Sets environment variables to keep 50+ tools XDG-compliant, including:

| Tool | Key Variables |
|------|---------------|
| **Cargo** | `CARGO_HOME=${XDG_DATA_HOME}/cargo` |
| **Bun** | `BUN_INSTALL=${XDG_DATA_HOME}/bun` |
| **Deno** | `DENO_INSTALL=${XDG_DATA_HOME}/deno` |
| **Go** | `GOPATH=${XDG_DATA_HOME}/go` |
| **Rustup** | `RUSTUP_HOME=${XDG_DATA_HOME}/rustup` |
| **NVM** | `NVM_DIR=${XDG_DATA_HOME}/nvm` |
| **PNPM** | `PNPM_HOME=${XDG_DATA_HOME}/pnpm` |
| **Docker** | `DOCKER_CONFIG=${XDG_CONFIG_HOME}/docker` |
| **Gradle** | `GRADLE_USER_HOME=${HOME}/gradle` |
| **tmux** | `TMUX_PLUGIN_MANAGER_PATH=${XDG_DATA_HOME}/tmux/plugins` |
| **Android SDK** | `ANDROID_USER_HOME=${XDG_DATA_HOME}/android`, `ANDROID_SDK_ROOT=/opt/android-sdk` |
| **asdf** | `ASDF_DATA_DIR=${XDG_DATA_HOME}/asdf` |

### PATH Construction

Appends to `$PATH` in order:
- PNPM home and binaries
- Spicetify, Deno, Bun
- Composer vendor bin
- Cargo, Go packages
- Android SDK tools (platform-tools, emulator, cmdline-tools, legacy tools)
- Flutter, Google Chrome
- asdf shims
- Dynamically discovered executable directories under `$SCRIPTS_DIR` (excluding `.git`, `.venv`, `venv`, `node_modules`)

### Gum Theme

Styles for TUI prompts using custom Tokyo Night colors — applied to filter, choose, confirm, input, spinner, write, and file picker widgets.

### LS_COLORS

Initializes via `dircolors` if not already set, enabling colorized file listings.

### Other Notable Variables

- `FZF_DEFAULT_COMMAND` — Uses `fd` for default fzf search
- `SUDO_ASKPASS` — Askpass program for sudo
- `MANPAGER` — Man pages piped through `bat`
- `GUM_*` — Complete theme for gum TUI toolkit

---

## options.sh

```bash
setopt extendedglob    # Extended globbing (#, ~, ^ operators)
unsetopt nomatch       # Don't error on globs with no matches
setopt AUTO_CD         # Type a directory name to cd into it
```

---

## plugins.sh

### Prompt

- **Starship** — Primary prompt (installed via zinit if not on system)
- **zsh-transient-prompt** — Collapses prompt after command execution

### Zinit Plugins

| Plugin | Purpose |
|--------|---------|
| `Aloxaf/fzf-tab` | fzf-powered tab completion with previews |
| `zdharma-continuum/fast-syntax-highlighting` | Async syntax highlighting |
| `MichaelAquilina/zsh-you-should-use` | Suggests existing aliases |
| `AhmedOsman101/zsh-auto-notify-fork` | Desktop notification on long commands |
| `zsh-users/zsh-completions` | Extra completion definitions |
| `hlissner/zsh-autopair` | Auto-close brackets/quotes |
| `AhmedOsman101/archlinux-zsh-plugin` | Arch package manager completions |
| `zsh-users/zsh-autosuggestions` | History-based autosuggestions |
| `olets/zsh-transient-prompt` | Transient prompt |

### Zinit Annexes

- `zinit-annex-as-monitor` — Monitor plugin changes
- `zinit-annex-bin-gem-node` — Binary/Gem/Node support
- `zinit-annex-patch-dl` — Patch downloading
- `zinit-annex-rust` — Rust compilation support

### OMZ Snippets

| Snippet | Purpose |
|---------|---------|
| `aliases` | Search all aliases by group |
| `alias-finder` | Suggest aliases for typed commands |
| `command-not-found` | Suggest packages for missing commands |
| `dirhistory` | Alt+Left/Right directory navigation |
| `encode64` | Base64 encoding/decoding helpers |
| `extract` | Universal archive extractor (`x`) |
| `gh` | GitHub CLI completions |
| `git` | Git aliases and helpers |
| `qrcode` | QR code generation |
| `rsync` | Rsync aliases |
| `rust` | Rust toolchain completions |

---

## completion.sh

- **fzf-tab** — Replaces default zsh completion menu with fzf
  - Preview directory contents with `eza` for `cd`, `z`, `__zoxide_z`
  - Preview all files with `eza` for `_files`
  - Tab key accepts selection in fzf
- **compinit** — Initialized with custom cache path
- **zstyle** — Case-insensitive matching, LS_COLORS in completion menu
- **find-the-command** — Suggests installation when command not found
- **select-word-style bash** — Word boundaries match bash behavior
- **Region highlight** — Disabled (fg/bg set to none)

---

## history.sh

```bash
HISTSIZE=999999
SAVEHIST=999999
HISTFILE="$HOME/.zsh_history"
HISTDUP=erase
HISTTIMEFORMAT="%F %T "
```

### Options

| Option | Effect |
|--------|--------|
| `appendhistory` | Append (don't overwrite) history |
| `share_history` | Share history across shell sessions |
| `hist_ignore_space` | Commands starting with space are not recorded |
| `hist_ignore_all_dups` | Remove older duplicate entries |
| `hist_ignore_dups` | Skip adjacent duplicates |
| `hist_save_no_dups` | Don't save duplicates to file |
| `hist_find_no_dups` | Skip duplicates when searching |
| `extended_history` | Record timestamps |
| `inc_append_history` | Write commands immediately |

Deduplication is also run via `no-dups` utility on the history file.

---

## hooks.sh

### rehash_precmd (precmd)

Rehashes zsh only when pacman modifies `/usr/bin`. Triggered by an Arch Linux pacman hook at `/usr/share/libalpm/hooks/archcraft-hook-zsh.hook`. Compares cache timestamps to avoid unnecessary rehashing.

### python-hook (chpwd)

Automatically activates/deactivates Python virtual environments when changing directories:
- Deactivates when leaving a project directory (checks `$VIRTUAL_ENV` parent)
- Activates `.venv/bin/activate` or `venv/bin/activate` when entering a project directory
- Walks up the directory tree until it finds a venv or reaches `/`

---

## aliases.sh

See [aliases.md](./aliases.md) for the complete reference.

---

## secrets.sh

Sources API keys from `pass` (GPG-encrypted password store).

### Managed Secrets

| Variable | pass entry |
|----------|------------|
| `GEMINI_API_KEY` | `gemini` |
| `OPENAI_API_KEY` | `openai` |
| `GITHUB_TOKEN` | `github/tokens/main` |
| `ANTHROPIC_API_KEY` | `agent-router` |
| `ADVENT_OF_CODE_SESSION` | `advent-of-code` |
| `AI_GATEWAY_API_KEY` | `vercel/ai-gateway` |
| `CONTEXT7_API_KEY` | `context7` |
| `OBSIDIAN_API_KEY` | `obsidian/api-key` |
| `OPENROUTER_API_KEY` | `openrouter` |
| `ZAI_API_KEY` | `z.ai` |
| `ANILIST_TOKEN` | `anilist/access-token` |
| `FEATHERLESS_API_KEY` | `featherless` |
| `HF_TOKEN` | `hugging-face` |

Skips `pass` lookups if all variables are already set (avoids unnecessary decryption).

---

## keybinds.sh

See [keybindings.md](./keybindings.md) for the complete reference.

---

## apps/helix-zsh.sh.disabled

Preserved helix-zsh config — rename to `helix-zsh.sh` to re-enable:
1. Sources `helix_zsh.zsh` from `$XDG_DATA_HOME/zsh/helix-zsh/`
2. Binds custom widgets in hxcmd/hxins/hxsel keymaps (fzf-tab, ctrl_l, edit-command-line, copybuffer, magic-space)
