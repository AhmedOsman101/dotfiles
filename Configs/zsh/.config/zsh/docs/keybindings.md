# Key Bindings Reference

## Input Mode

Native zsh vi mode (`bindkey -v`) with `vicmd`/`viins` keymaps.
Built-in, zero dependencies — works with atuin, fzf-tab, and autosuggestions natively.

Previous helix-zsh config preserved at `apps/helix-zsh.sh.disabled` for easy revert.

| Keymap | Mode | Description |
|--------|------|-------------|
| `vicmd` | Normal | Vim navigation & manipulation |
| `viins` | Insert | Text entry (default) |

## Standard Keys

| Binding | Widget | Description |
|---------|--------|-------------|
| `Home` / `^[[H` / `^[[1~` | `beginning-of-line` | Go to line start |
| `End` / `^[[F` / `^[[4~` | `end-of-line` | Go to line end |
| `Delete` / `^[[3~` | `delete-char` | Delete forward |

## Word Navigation

| Binding | Widget | Description |
|---------|--------|-------------|
| `Ctrl+Right` / `^[[1;5C` | `forward-word` | Next word |
| `Ctrl+Left` / `^[[1;5D` | `backward-word` | Previous word |

## Undo / Redo

| Binding | Widget | Description |
|---------|--------|-------------|
| `Ctrl+Z` | `undo` | Undo |
| `Ctrl+Y` | `redo` | Redo |

## Custom Widgets

### Ctrl+L — Clear Screen (without scrollback)

```zsh
ctrl_l() {
  builtin print -rn -- $'\r\e[0J\e[H\e[22J' >"${TTY}"
  builtin zle .reset-prompt
  builtin zle -R
}
```

Clears the screen and resets the prompt without affecting scrollback buffer.

### Ctrl+X Ctrl+E — Edit Command in Editor

Opens the current command line in `$EDITOR` (`hx`, `helix`, `nvim`, etc.). Supports:
- **Visual/line selection** — Only the selected region is edited
- **Multiline buffers (PS2)** — Continuation lines are included
- **vim integration** — Cursor placed at correct byte offset
- **emacs integration** — Cursor placed at correct line

### Ctrl+O — Copy Buffer to Clipboard

```zsh
copybuffer() {
  if command -v clipcopy &>/dev/null; then
    clipcopy "${BUFFER}"
    zle -M "Copied buffer to clipboard"
  fi
}
```

Works in emacs, viins, and vicmd modes.

### Shift+Tab — Magic Space

| Binding | Widget | Description |
|---------|--------|-------------|
| `Shift+Tab` / `^[[Z` | `magic-space` | Expand history expansion |

## OMZ dirhistory (Alt+Arrow)

| Binding | Widget | Description |
|---------|--------|-------------|
| `Alt+Left` | `dirhistory_backward` | Previous directory in history |
| `Alt+Right` | `dirhistory_forward` | Next directory in history |

Provided by the OMZ `dirhistory` snippet loaded in plugins.sh.
