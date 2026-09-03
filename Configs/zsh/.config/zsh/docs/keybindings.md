# Key Bindings Reference

Source: `keybinds.sh` (loaded 5th). Current mode is **emacs** (`bindkey -e`). ZVM/helix configs are disabled but preserved.

## Mode

| File | Mode | How to toggle |
|------|------|---------------|
| `keybinds.sh` (active) | `bindkey -e` — emacs | default; widgets bound to `emacs`/`viins`/`vicmd` |
| `keybinds.sh.bak` | ZVM vi — `viins`/`vicmd` + `zvm_after_init` | Uncomment `zinit light jeffreytse/zsh-vi-mode` in `plugins.sh`, remove `unset -f zvm_config`, `mv keybinds.sh.bak keybinds.sh` |
| `apps/helix-zsh.sh.disabled` | Helix (`hxins`/`hxcmd`/`hxsel`) | `mv helix-zsh.sh.disabled helix-zsh.sh` |

OMZ `dirhistory`, fzf-tab, and autosuggestions work natively in emacs mode.

## Standard Keys

| Binding | Sequences | Widget | Notes |
|---------|-----------|--------|-------|
| `Home` | `^[[H`, `^[[1~` | `beginning-of-line` | Generic keymap |
| `End` | `^[[F`, `^[[4~` | `end-of-line` | Generic keymap |
| `Delete` | `^[[3~` | `delete-char` | Generic keymap |

## Word Navigation

| Binding | Sequence | Widget |
|---------|----------|--------|
| `Ctrl+Right` | `^[[1;5C` | `forward-word` |
| `Ctrl+Left` | `^[[1;5D` | `backward-word` |

## Undo / Redo

| Binding | Widget |
|---------|--------|
| `Ctrl+Z` (`^Z`) | `undo` |
| `Ctrl+Y` (`^Y`) | `redo` |

## Custom Widgets

### `Ctrl+L` — Clear without scrollback

```zsh
ctrl_l() {
  builtin print -rn -- $'\r\e[0J\e[H\e[22J' >"${TTY}"
  builtin zle .reset-prompt
  builtin zle -R
}
zle -N ctrl_l
bindkey '^L' ctrl_l
```

Sends CSI clear + resets Starship/transient prompt.

### `Ctrl+X Ctrl+E` — Edit command in `$EDITOR`

```zsh
zle -N edit-command-line-sh
bindkey '^X^E' edit-command-line-sh
```

Implementation: `functions/edit-command-line-sh` (autoloaded in `plugins.sh`).

- Visual selection (`REGION_ACTIVE==1`) — edits only the selected region.
- Line selection (`REGION_ACTIVE==2`) — edits whole lines around selection.
- Multi-line `PS2` (`CONTEXT==cont`) — includes `PREBUFFER`; uses `print -Rz` + `send-break`.
- Cursor placement: vim → `normal! {byteoffset}go` (bytes, not chars), emacs → `+{line}:{col}`, other → plain.
- Bracketed paste toggled around editor invocation.

### `Ctrl+O` — Copy buffer to clipboard

```zsh
copybuffer() {
  if command -v clipcopy &>/dev/null; then
    clipcopy "${BUFFER}"
    zle -M "Copied buffer to clipboard"
  else
    zle -M "clipcopy not found. Please make sure you have Scripts installed correctly."
  fi
}
zle -N copybuffer
bindkey -M emacs "^O" copybuffer
bindkey -M viins "^O" copybuffer
bindkey -M vicmd "^O" copybuffer
```

Works in all three keymaps.

### `Shift+Tab` — Magic Space

| Binding | Sequence | Widget | Effect |
|---------|----------|--------|--------|
| `Shift+Tab` | `^[[Z` | `magic-space` | Expands history (`!`/`!!`) on space |

```zsh
bindkey '^[[Z' magic-space
```

## OMZ dirhistory (Alt+Arrow)

Provided by `zinit snippet OMZP::dirhistory` in `plugins.sh`.

| Binding | Widget | Description |
|---------|--------|-------------|
| `Alt+Left` | `dirhistory_backward` | Previous directory |
| `Alt+Right` | `dirhistory_forward` | Next directory |

## FZF & Completion (from `apps/fzf.sh` + `completion.sh`)

- `Ctrl+T` — fzf file finder (`FZF_CTRL_T_COMMAND="fd …"`, preview `fzf-preview {}`).
- `Alt+C` — fzf directory finder (`FZF_ALT_C_COMMAND="fd --type=d …"`, preview `eza --tree {}`).
- `Tab` — `fzf-tab` accept (`zstyle ':fzf-tab:*' fzf-flags --bind=tab:accept`); directory previews use `eza --long --no-time … $realpath`.

## ZVM Variant (`keybinds.sh.bak` — not active)

When ZVM is enabled, `zvm_after_init` / `zvm_after_lazy_keybindings` restore bindings after ZVM clears them:

- `autopair-init` re-enabled
- `viins`: `^K` kill-line, `^U` kill-whole-line, `^W` backward-kill-word, Home/End/Delete/Ctrl+Arrows mirrored per-mode
- `vicmd`: `gl` → `vi-end-of-line`, `gs` → `vi-first-non-blank`, `^K`/`^U`/`^Z`/`^Y` as above
- Helix variant (`apps/helix-zsh.sh.disabled`) additionally binds `^I` → `fzf-tab-complete` and `^X^E`/`^O`/`^[[Z` in all helix keymaps via `_hx_bindkey_all`.
