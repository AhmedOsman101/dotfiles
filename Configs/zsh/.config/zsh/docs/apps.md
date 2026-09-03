# App Configurations

Loaded after all core modules via `for app in "$ZSH_CONF/apps"/*.sh` in `.zshrc`. Only `*.sh` is sourced — `*.sh.disabled` is ignored (rename to enable).

> Order is filesystem glob order; each file guards with `command -v` / `[[ -s … ]]` so missing tools are no-ops.

## Active Apps (17)

### atuin.sh

[Atuin](https://atuin.sh) — encrypted, syncable shell history.

```bash
[[ ":$PATH:" != *":$HOME/.atuin/bin:"* ]] && export PATH="$HOME/.atuin/bin:$PATH"
[[ -s "$HOME/.local/bin/atuin.sh" ]] && source "$HOME/.local/bin/atuin.sh"
eval "$(atuin gen-completions --shell zsh)"
```

### bun.sh

[Bun](https://bun.sh) runtime.

```bash
bun completions &>/dev/null
[[ -s "$BUN_INSTALL/_bun" ]] && source "$BUN_INSTALL/_bun"
```

### cargo.sh

[Cargo](https://doc.rust-lang.org/cargo/) env.

```bash
[[ -s "$CARGO_HOME/env" ]] && source "$CARGO_HOME/env" &>/dev/null
```

### curlie.sh

[Curlie](https://curlie.io) — httpie UX for curl.

```bash
[[ -s "$HOME/.config/envman/load.sh" ]] && source "$HOME/.config/envman/load.sh"
```

### delta.sh

[Delta](https://github.com/dandavison/delta) — syntax-highlighted `git diff`.

```bash
eval "$(delta --generate-completion zsh)"
```

### deno.sh

[Deno](https://deno.com) runtime.

```bash
[[ -s "$XDG_CACHE_HOME/deno/env" ]] && source "$XDG_CACHE_HOME/deno/env"
command -v deno &>/dev/null && eval "$(deno completions zsh --dynamic)"
```

### fzf.sh

[Fzf](https://github.com/junegunn/fzf) — fuzzy finder.

```bash
command -v fzf &>/dev/null && source <(fzf --zsh)

_fzf_compgen_path() { fd --hidden --exclude .git . "$1"; }
_fzf_compgen_dir()  { fd --type=d --hidden --exclude .git . "$1"; }

_fzf_comprun() {
  case "$1" in
    cd|z)          fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset)  fzf --preview "eval 'echo {}'" "$@" ;;
    ssh)           fzf --preview 'dig {}' "$@" ;;
    *)             fzf --preview "fzf-preview {}" "$@" ;;
  esac
}
```

Respects `FZF_DEFAULT_COMMAND="fd --hidden …"` and `FZF_DEFAULT_OPTS` from `variables.sh`.

### micromamba.sh

[Micromamba](https://mamba.readthedocs.io/) — fast conda.

```bash
[[ -s "$XDG_DATA_HOME/micromamba.sh" ]] && source "$XDG_DATA_HOME/micromamba.sh"
```

### mise.sh

[mise](https://mise.jdx.dev) — runtime version manager.

```bash
eval "$(mise activate zsh)"
mise completion bash --include-bash-completion-lib >"$XDG_DATA_HOME/bash-completion/completions/mise"
mise completion zsh >"$ZDOTDIR/completions/_mise"
```

Writes completions to `completions/_mise` (checked into `FPATH` by `completion.sh`).

### omp.sh

[Oh My Pi](https://github.com/nicepkg/omp) — Pi coding harness.

```bash
eval "$(omp completions zsh)"
```

### opencode.sh

[OpenCode](https://opencode.ai) — AI coding assistant.

```bash
eval "$(opencode completion zsh)"
```

### php-cs-fixer.sh

[PHP-CS-Fixer](https://github.com/PHP-CS-Fixer/PHP-CS-Fixer).

```bash
eval "$(php-cs-fixer completion zsh)"
```

### pnpm.sh

[pnpm](https://pnpm.io) — fast package manager. Guarded to avoid duplicate PATH.

```bash
if command -v pnpm &>/dev/null; then
  export PATH="$PNPM_HOME/bin:$PATH"
fi
```

### podman.sh

[Podman](https://podman.io) — daemonless containers.

```bash
command -v podman &>/dev/null && podman completion zsh 2>/dev/null >"$ZSH_CACHE_DIR/completions/_podman"
```

> `ZSH_CACHE_DIR` is typically `$XDG_CACHE_HOME/zsh`; completions there are picked up via `FPATH`/`compinit`.

### transient-prompt.sh

[zsh-transient-prompt](https://github.com/olets/zsh-transient-prompt) — collapses prompt after execution. Loaded **after** Starship (which is in `plugins.sh`).

```bash
TRANSIENT_PROMPT_PROMPT=$'$(starship prompt)'   # full prompt while typing
source "$ZINIT_HOME/../plugins/olets---zsh-transient-prompt/transient-prompt.zsh-theme"

typeset -g LAST_EXECUTED_CMD=""
transient_preexec() { LAST_EXECUTED_CMD=$1; }   # preexec hook — store cmd
transient_precmd() {                            # precmd hook — set char + blank line
  local _status=$?
  (( _status == 0 )) && TRANSIENT_CHAR='%F{green}❯%f ' || TRANSIENT_CHAR='%F{red}✗%f '
  printf '\n'
}
add-zsh-hook preexec transient_preexec
add-zsh-hook precmd  transient_precmd
TRANSIENT_PROMPT_TRANSIENT_PROMPT=$'$TRANSIENT_CHAR'
```

Result: typing shows Starship 2-line prompt; after `Enter`, previous prompt collapses to `❯` or `✗`.

### uv.sh

[uv](https://github.com/astral-sh/uv) — fast Python package manager.

```bash
eval "$(uv generate-shell-completion zsh)"
eval "$(uvx --generate-shell-completion zsh)"
```

### zoxide.sh

[Zoxide](https://github.com/ajeetdsouza/zoxide) — frecency `cd`.

```bash
command -v zoxide &>/dev/null && eval "$(zoxide init zsh)"
```

Pairs with `alias cd=z` from `aliases.sh`.

---

## Disabled Apps

| File | Purpose | Enable |
|------|---------|--------|
| `fuck.sh.disabled` | [thefuck](https://github.com/nvbn/thefuck) — `eval "$(thefuck --alias)"` → `fuck`/`f` | `mv fuck.sh.disabled fuck.sh` |
| `helix-zsh.sh.disabled` | [helix-zsh](https://github.com/mattfbacon/helix-zsh) — sources `$XDG_DATA_HOME/zsh/helix-zsh/helix_zsh.zsh` then binds `fzf-tab`, `ctrl_l`, `edit-command-line-sh`, `copybuffer`, `magic-space` in `hx*` keymaps | `mv helix-zsh.sh.disabled helix-zsh.sh` |

Also see `keybinds.sh.bak` for the ZVM-era keybind variant that pairs with `helix-zsh`.
