if status is-interactive
    set -g fish_greeting
    # prompt.
    if command -v starship >/dev/null 2>&1
        starship init fish | source
        # @fish-lsp-disable-next-line 7001
        enable_transience
    end
    # directory jumper: hook `cd` into zoxide so plain `cd` learns and jumps to
    # frecent dirs (`cdi` for an interactive pick).
    if command -v zoxide >/dev/null 2>&1
        zoxide init fish --cmd cd | source
    end

    # runtime version manager: shims + per-project tool versions.
    if command -v mise >/dev/null 2>&1
        mise activate fish | source
    end

    # fzf walks the tree via fd when present.
    if command -v fd >/dev/null 2>&1
        set -gx FZF_DEFAULT_COMMAND 'fd --hidden --follow --exclude .git'
        set -gx FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND
        set -gx FZF_ALT_C_COMMAND 'fd --type d --hidden --follow --exclude .git'
    end

    # fzf keys: Ctrl-R history, Ctrl-T files, Alt-C cd.
    if command -v fzf >/dev/null 2>&1
        fzf --fish | source
    end

    # eza listings.
    if command -v eza >/dev/null 2>&1
        alias ls 'eza -lh --group-directories-first --icons=auto'
        alias lsa 'ls -a'
        alias lt 'eza --tree --level=2 --long --icons --git'
        alias lta 'lt -a'
    end
end

set -q SCRIPTS_DIR; or set -gx SCRIPTS_DIR "$HOME/scripts"
set -q EDITOR; or set -gx EDITOR hx
set -q VISUAL; or set -gx VISUAL hx

fish_add_path $SCRIPTS_DIR
test -s "$SCRIPTS_DIR/hooks/path.fish"; and source "$SCRIPTS_DIR/hooks/path.fish"

if test -d $HOME/.local/bin
    fish_add_path $HOME/.local/bin
end

# point `go install` and `cargo install` at ~/.local/bin
set -gx GOBIN $HOME/.local/bin
set -gx CARGO_INSTALL_ROOT $HOME/.local

# keep an existing editor choice.
set -q EDITOR; or set -gx EDITOR hx
set -q VISUAL; or set -gx VISUAL hx
