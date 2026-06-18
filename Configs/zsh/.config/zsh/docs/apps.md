# App Configurations

Loaded after all core modules via `apps/*.sh` loop in `.zshrc`.

## atuin.sh

[Atuin](https://atuin.sh) — SQLite-backed shell history with encryption and sync.

```bash
export PATH="${HOME}/.atuin/bin:${PATH}"
source "${HOME}/.local/bin/atuin.sh"  # Atuin's shell integration
eval "$(atuin gen-completions --shell zsh)"
```

## bun.sh

[Bun](https://bun.sh) — JavaScript runtime & toolkit.

```bash
bun completions  # Generates completions
source "${BUN_INSTALL}/_bun"  # Loads completion file
```

## cargo.sh

[Cargo](https://doc.rust-lang.org/cargo/) — Rust package manager.

```bash
source "${CARGO_HOME}/env"  # Cargo environment (adds to PATH)
```

## curlie.sh

[Curlie](https://curlie.io) — Frontend to curl with the usability of httpie.

```bash
source "${HOME}/.config/envman/load.sh"  # envman integration
```

## delta.sh

[Delta](https://github.com/dandavison/delta) — Git diff viewer with syntax highlighting.

```bash
eval "$(delta --generate-completion zsh)"
```

## deno.sh

[Deno](https://deno.com) — JavaScript/TypeScript runtime.

```bash
source "${XDG_CACHE_HOME}/deno/env"  # Deno environment
eval "$(deno completions zsh --dynamic)"  # Dynamic completions
```

## fuck.sh

[thefuck](https://github.com/nvbn/thefuck) — Corrects mistyped console commands.

```bash
eval "$(thefuck --alias)"  # Alias `fuck` (and `f` by default)
```

## fzf.sh

[Fzf](https://github.com/junegunn/fzf) — Command-line fuzzy finder.

```bash
source <(fzf --zsh)  # Key bindings and completion
```

### Custom completion generators

- `_fzf_compgen_path` — Uses `fd` for file path completion
- `_fzf_compgen_dir` — Uses `fd` for directory completion
- `_fzf_comprun` — Context-aware previews:
  - `cd`/`z` → eza tree preview
  - `export`/`unset` → eval preview
  - `ssh` → dig preview
  - default → `fzf-preview`

## micromamba.sh

[Micromamba](https://mamba.readthedocs.io/) — Fast conda alternative.

```bash
source "${XDG_DATA_HOME}/micromamba.sh"
```

## mise.sh

[mise](https://mise.jdx.dev) — Runtime version manager (asdf successor).

```bash
eval "$(mise activate zsh)"  # Runtime activation (hooks, shims)
mise completion bash --include-bash-completion-lib > ...
mise completion zsh > "${ZDOTDIR}/completions/_mise"  # Zsh completion
```

## opencode.sh

[OpenCode](https://opencode.ai) — AI coding assistant.

```bash
eval "$(opencode completion zsh)"
```

## php-cs-fixer.sh

[PHP-CS-Fixer](https://github.com/PHP-CS-Fixer/PHP-CS-Fixer) — PHP coding standards tool.

```bash
eval "$(php-cs-fixer completion zsh)"
```

## pnpm.sh

[pnpm](https://pnpm.io) — Fast, disk space efficient package manager.

```bash
export PATH="${PNPM_HOME}/bin:${PATH}"
```

## podman.sh

[Podman](https://podman.io) — Daemonless container engine.

```bash
podman completion zsh > "${ZSH_CACHE_DIR}/completions/_podman"
```

## transient-prompt.sh

[zsh-transient-prompt](https://github.com/olets/zsh-transient-prompt) — Prompt collapses after command execution.

### Behavior

- **Full prompt** (while typing): Starship 2-line prompt with directory, git status, OS icon
- **Transient prompt** (after command): Single character — `❯` (green, exit 0) or `✗` (red, non-zero exit)

### Implementation details

```zsh
# Full prompt — delegates to Starship
TRANSIENT_PROMPT_PROMPT='$(starship prompt)'

# Transient prompt — exit status indicator
TRANSIENT_PROMPT_TRANSIENT_PROMPT='$TRANSIENT_CHAR'
```

Hooks:
- `transient_preexec` — Stores the last executed command
- `transient_precmd` — Sets `$TRANSIENT_CHAR` based on exit status; adds blank line

## uv.sh

[uv](https://github.com/astral-sh/uv) — Fast Python package manager (pip/venv replacement).

```bash
eval "$(uv generate-shell-completion zsh)"
eval "$(uvx --generate-shell-completion zsh)"
```

## zoxide.sh

[Zoxide](https://github.com/ajeetdsouza/zoxide) — Smarter cd command (frecency-based).

```bash
eval "$(zoxide init zsh)"
```
