# Module Reference

Load order is defined in `.zshrc` `MODULES=(…)` and respected strictly (see `README.md` flowchart). All modules are sourced only if `[[ -s "$ZSH_CONF/$module" ]]`. Concurrency guard `lock.sh` runs outside this list — at the very top of `.zshrc` before zinit.

---

## lock.sh (concurrency guard — before all modules)

Sourced immediately after `[[ -o interactive ]] || return` in `.zshrc`, released before `tmux ls`. Prevents the tmux-resurrect/continuum thundering herd: N panes restore at once → N `zsh -i` race on `compinit`, `zinit`, `.zcompdump`, and file writes.

```zsh
# Top of .zshrc
if [[ -s "${ZDOTDIR}/lock.sh" ]]; then
  source "${ZDOTDIR}/lock.sh"   # auto-acquires
fi
# ... modules + apps ...
(( $+functions[_zshrc_lock_release] )) && _zshrc_lock_release  # before tmux
```

**Mechanism (fallback chain):**

1. **External `flock`** (util-linux, preferred) — `exec {fd}> "$lock"` + `flock -w $timeout $fd`. Kernel-queued FIFO, per-FD, auto-released on close. Lock file: `${XDG_CACHE_HOME:-~/.cache}/zsh/.zshrc.lock`.
2. **`zsystem flock`** (builtin) — `zsystem flock -t $timeout -f zfd "$lock"` + `zsystem flock -u $zfd`. Used if `flock` binary missing.
3. **`mkdir` spin** — `mkdir "$lock.dir"` atomic; stale dirs reaped after `2*timeout` (default 120s). Sleep 0.05s poll.

**Properties:**

| Property | Detail |
|----------|--------|
| Held duration | Only `.zshrc` sourcing (~0.5–2s per shell), not shell lifetime. Verified: 5 parallel `zsh -i` queue strictly (no overlap, see tests below). |
| Timeout | `ZSHRC_LOCK_TIMEOUT=60` (0 = infinite). Workers block up to timeout, then fall back/proceed with warning. |
| Re-entrancy | Idempotent: `__ZSHRC_LOCK_HELD` guard preserves state across re-source; `reload` (source `.zshrc` again) is safe (second source is no-op, fd preserved). |
| Stale-safe | `flock`/`zsystem` auto-release on FD close / exit. `mkdir` has TTL + `rm -rf` reap. |
| Safety net | `TRAPEXIT` / `zshexit` hook releases if shell exits mid-`.zshrc` (e.g., `return`/`exit`). |
| Debug | `ZSHRC_LOCK_DEBUG=1 zsh -i -c 'true'` — prints waiting/acquired/releasing via `print -P`. |
| Custom path | `ZSHRC_LOCK_FILE=/tmp/my.lock` overrides. |

Tested: 5 parallel non-interactive + 5 interactive shells show strict serialization (`start N > end N-1`), no overlap; fallback `mkdir` and re-entrancy pass.

---

## variables.sh (1st — must be first)

Defines every XDG var and `PATH`. Sourced early so later modules can rely on env.

### XDG Base

```bash
XDG_CONFIG_HOME="$HOME/.config"
XDG_CACHE_HOME="$HOME/.cache"
XDG_DATA_HOME="$HOME/.local/share"
XDG_STATE_HOME="$HOME/.local/state"
```

### Notable Exports (selection; full file is ~304 lines)

| Group | Key Variables |
|-------|---------------|
| **XDG shims** | `CARGO_HOME`, `BUN_INSTALL=.local/share/bun`, `DENO_INSTALL=$HOME/.deno`, `GOPATH`, `RUSTUP_HOME`, `NVM_DIR`, `PNPM_HOME`, `DOCKER_CONFIG`, `GRADLE_USER_HOME=~/gradle`, `TMUX_PLUGIN_MANAGER_PATH`, `ANDROID_USER_HOME`/`ANDROID_SDK_ROOT`/`ANDROID_HOME`, `ASDF_DATA_DIR`/`ASDF_DIR`, `NPM_CONFIG_USERCONFIG`, `NODE_REPL_HISTORY`, `WGETRC`, `W3M_DIR`, `PARALLEL_HOME`, `PASSWORD_STORE_DIR`, `GOPATH`, `NUGET_PACKAGES`, `PIPER_DIR`, `TEXMFVAR`, … |
| **App config** | `BATDIFF_USE_DELTA=true`, `BIOME_CONFIG_PATH`, `STARSHIP_CONFIG`, `BUNDLE_USER_CONFIG/CACHE/PLUGIN`, `OPENCODE_ENABLE_EXA=1`, `PI_SUBAGENT_SHELL_READY_DELAY_MS=2500` |
| **UI** | `U_*` Tokyo Night palette (`U_BLACK`/`U_RED`/…`U_PURPLE`), `GUM_*` theme (filter/choose/confirm/input/spinner/write/file), `LS_COLORS` via `dircolors`, `FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"` + `FZF_DEFAULT_OPTS` (Catppuccin), `MANPAGER="col -bx | bat --language=man -p"` |
| **Runtime** | `DENO_UNSTABLE_SLOPPY_IMPORTS=true`, `PYTHONSTARTUP`, `PUB_CACHE`, `NODE_PACKAGE_MANAGER=pnpm` |
| **System** | `SUDO_ASKPASS="$(get-askpass)"` (overwritten in `.zshenv` via command probe), `__EGL_VENDOR_LIBRARY_FILENAMES` on desktop, `XINITRC`, `YSU_MESSAGE_POSITION=after`, `AUTO_NOTIFY_IGNORE=(… ~30 cmds)` + `AUTO_NOTIFY_THRESHOLD=30` |

### PATH Construction (appended in order, then `export PATH`)

```bash
PNPM_HOME
PNPM_HOME/bin
~/.spicetify
DENO_INSTALL/bin
BUN_INSTALL/bin
~/.config/composer/vendor/bin
CARGO_HOME/bin
GOPATH/bin
ANDROID_HOME/platform-tools
ANDROID_HOME/emulator
ANDROID_HOME/cmdline-tools/latest/bin
ANDROID_HOME/tools/bin
ANDROID_HOME/tools               # legacy
~/opt/flutter/bin
/opt/google/chrome/
/.local/share/../bin             # UV binaries
~/.lmstudio/bin
ASDF_DATA_DIR/shims
# plus from .zshenv: SCRIPTS_DIR, XONSH_HOME/xbin, ~/.local/bin
```

> **Note:** Earlier docs claimed dynamic discovery of executable dirs under `$SCRIPTS_DIR`. That loop does not exist in the current file — `PATH` is static above.

---

## options.sh (2nd)

```bash
setopt extendedglob    # #, ~, ^ operators
unsetopt nomatch       # no error on non-matching globs
setopt AUTO_CD         # bare directory name → cd
```

---

## functions.sh (3rd)

See [functions.md](./functions.md). Sourced after `variables.sh` so helpers like `clipcopy`/`collapseTilde` from `${SCRIPTS_DIR}/lib/helpers.sh` are available.

---

## plugins.sh (4th — may define aliases/completions)

### Starship Prompt

```bash
if command -v starship &>/dev/null; then
  eval "$(starship init zsh)"
else
  zinit ice as"command" from"gh-r" \
    atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
    atpull"%atclone" src"init.zsh"
  zinit light starship/starship
fi
```

### Zinit Lights (9)

| Plugin | Purpose |
|--------|---------|
| `Aloxaf/fzf-tab` | fzf-powered tab completion + previews |
| `zdharma-continuum/fast-syntax-highlighting` | Async syntax highlighting |
| `MichaelAquilina/zsh-you-should-use` | Suggests existing aliases |
| `AhmedOsman101/zsh-auto-notify-fork` | Desktop notify on long commands (respects `AUTO_NOTIFY_*`) |
| `zsh-users/zsh-completions` | Extra completion defs |
| `hlissner/zsh-autopair` | Auto-close brackets/quotes |
| `AhmedOsman101/archlinux-zsh-plugin` | Pacman helpers |
| `zsh-users/zsh-autosuggestions` | History-based suggestions (async) |
| `olets/zsh-transient-prompt` | Collapses prompt after execution |

### ZVM (disabled)

```zsh
function zvm_config() { ZVM_LINE_INIT_MODE=insert; ZVM_VI_INSERT_ESCAPE_BINDKEY='jk'; … }
# zinit ice depth=1
# zinit light 'jeffreytse/zsh-vi-mode'
unset -f zvm_config
```

Toggle: uncomment the two `zinit` lines and remove `unset -f`. When enabled, ZVM uses `jk` escape, underline/block cursors, `s-prefix` surround, system clipboard, and custom highlight colors. Current `keybinds.sh` uses `bindkey -e` (emacs); see `keybinds.sh.bak` for the ZVM-era bindings.

### Zinit Annexes (light-mode, no Turbo)

`zinit-annex-as-monitor`, `zinit-annex-bin-gem-node`, `zinit-annex-patch-dl`, `zinit-annex-rust`

### OMZ Snippets (11 active + 2 commented)

Active: `aliases`, `alias-finder`, `command-not-found`, `dirhistory`, `encode64`, `extract`, `gh`, `git`, `qrcode`, `rsync`, `rust`.
Commented: `gpg-agent`, `safe-paste`.

### Autoloads

```zsh
autoload -Uz edit-command-line-sh   # custom widget (functions/edit-command-line-sh)
autoload    zmv                     # advanced mv
autoload -Uz run-help; unalias run-help
autoload -Uz add-zsh-hook
autoload -Uz promptinit; promptinit
```

---

## keybinds.sh (5th — depends on plugins for widgets)

See [keybindings.md](./keybindings.md). Current: `bindkey -e` (emacs). ZVM variant archived in `keybinds.sh.bak`.

---

## completion.sh (6th — after plugins that register completions)

```zsh
# fzf-tab replaces default menu
zstyle ':fzf-tab:complete:cd:*'            fzf-preview 'eza … $realpath'
zstyle ':fzf-tab:complete:z:*'             fzf-preview 'eza … $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*'    fzf-preview 'eza … $realpath'
zstyle ':fzf-tab:complete:_files:*'        fzf-preview 'eza … $realpath'
zstyle ':fzf-tab:*' fzf-flags --color=fg:1,fg+:2 --bind=tab:accept

# General
zstyle ':completion:*:git-checkout:*' sort false
zstyle ':completion:*:descriptions'   format '[%d]'
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'  # case-insensitive
zstyle ':completion:*' list-colors "${LS_COLORS}"
zstyle ':completion:*' menu no                                # disable default menu
zstyle :compinstall filename "${ZSHRC}"
zstyle ':omz:plugins:alias-finder' autoload yes
zstyle ':zle:*' region-highlight 'fg=none' 'bg=none'          # disable region bg

autoload -Uz compinit
compinit -d "${XDG_CACHE_HOME}/zsh/zcompdump-${ZSH_VERSION}"
zinit cdreplay -q

# find-the-command (Arch) — suggests pkg for missing cmd
ftc='/usr/share/doc/find-the-command/ftc.zsh'
[[ -s "${ftc}" ]] && source "${ftc}" quiet noupdate

autoload -Uz select-word-style; select-word-style bash
FPATH="${ZSH_CONF}/completions:${FPATH}"
export FPATH="${FPATH}:/usr/share/zsh/functions:/usr/share/zsh/functions/Zle"
```

---

## history.sh (7th)

```bash
HISTSIZE=999999
SAVEHIST=999999
HISTFILE="$HOME/.zsh_history"
HISTDUP=erase
HISTTIMEFORMAT="%F %T "
HISTCONTROL="ignoreboth"
setopt appendhistory hist_ignore_space hist_ignore_all_dups hist_ignore_dups
setopt hist_save_no_dups hist_find_no_dups extended_history inc_append_history share_history
command -v no-dups &>/dev/null && no-dups -f -q "${HISTFILE}"
```

All history is shared across sessions (`share_history` + `inc_append_history`) and deduplicated both at lookup and on disk via `no-dups`.

---

## hooks.sh (8th)

### `rehash_precmd` (precmd)

Triggered by Arch pacman hook `/usr/share/libalpm/hooks/archcraft-hook-zsh.hook`. Compares `/var/cache/zsh/pacman` mtime vs cached `zshcache_time` (nanos); calls `rehash` only when pacman actually updated `/usr/bin`.

### `python-hook` (chpwd)

Walks up from `$PWD` to `/`:
- If `$VIRTUAL_ENV` set and `$PWD` no longer under it → `deactivate`.
- If already in a venv → no-op.
- Else search parents for `.venv/bin/activate` then `venv/bin/activate` → source it (prints green/yellow status).

```zsh
add-zsh-hook -Uz precmd rehash_precmd
add-zsh-hook -Uz chpwd  python-hook
[[ -s "${SCRIPTS_DIR}/hooks/path.sh" ]] && source "${SCRIPTS_DIR}/hooks/path.sh"
```

The trailing `path.sh` hook (from scripts repo) is optional and not tracked here.

---

## aliases.sh (9th — MUST be late to override OMZ)

See [aliases.md](./aliases.md) for full table. Includes `unalias g/gcm/zi` to remove OMZ/zinit defaults, plus suffix (`-s`) and global (`-g`) aliases.

---

## secrets.sh (last)

GPG-encrypted keys via `pass`. Short-circuits if all vars already set (avoids decryption).

```zsh
_vars=(ADVENT_OF_CODE_SESSION AI_GATEWAY_API_KEY ANILIST_TOKEN ANTHROPIC_API_KEY
        CONTEXT7_API_KEY EXA_API_KEY FEATHERLESS_API_KEY GEMINI_API_KEY GITHUB_TOKEN
        GOOGLE_GENERATIVE_AI_API_KEY HF_TOKEN KIRO_PROXY_API_KEY NVIDIA_API_KEY
        OBSIDIAN_API_KEY OPENAI_API_KEY OPENROUTER_API_KEY ZAI_API_KEY
        N9ROUTER_API_KEY OMNIROUTE_API_KEY)
for _var in "${_vars[@]}"; do [[ -z "${(P)_var}" ]] && _allChecked=false && break; done
[[ $_allChecked ]] && return 0
```

Active assignments (uncommented):

| Variable | `pass` entry |
|----------|--------------|
| `EXA_API_KEY` | `exa-search` |
| `GEMINI_API_KEY` | `gemini` |
| `GITHUB_TOKEN` | `github/tokens/main` (head -1) |
| `GOOGLE_GENERATIVE_AI_API_KEY` | ← `GEMINI_API_KEY` |
| `HF_TOKEN` | `hugging-face` |
| `NVIDIA_API_KEY` | `nvidia/api-key` |
| `OPENROUTER_API_KEY` | `openrouter` |
| `N9ROUTER_API_KEY` | `9router` |
| `OMNIROUTE_API_KEY` | `omniroute` |

Commented (enable by uncommenting): `ADVENT_OF_CODE_SESSION`, `AI_GATEWAY_API_KEY`, `ANILIST_TOKEN`, `CONTEXT7_API_KEY`, `FEATHERLESS_API_KEY`, `KIRO_PROXY_API_KEY`, `OBSIDIAN_API_KEY`, `OPENAI_API_KEY`, `ZAI_API_KEY`, `ANTHROPIC_API_KEY` (was aliased to `N9ROUTER`).

Then `export "${_vars[@]}"` and cleanup.

---

## Disabled / Optional

### `apps/helix-zsh.sh.disabled`

Helix keybindings (rename to `helix-zsh.sh` to enable):
1. Sources `helix_zsh.zsh` from `${XDG_DATA_HOME}/zsh/helix-zsh/`.
2. Binds widgets in `hxcmd`/`hxins`/`hxsel` via `_hx_bindkey_all` (fzf-tab, ctrl_l, edit-command-line, copybuffer, magic-space).

### `apps/fuck.sh.disabled` and `keybinds.sh.bak`

Preserved configs for `thefuck` (`thefuck --alias`) and ZVM-era emacs/viins/vicmd bindings (see `keybindings.md`).
