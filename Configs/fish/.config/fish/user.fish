if status is-interactive
    # Commands to run in interactive sessions can go here
end

if command -v starship >/dev/null 2>&1
    # @fish-lsp-disable-next-line 7001
    enable_transience
end

set -q SCRIPTS_DIR; or set -gx SCRIPTS_DIR "$HOME/scripts"
set -q EDITOR; or set -gx EDITOR hx
set -q VISUAL; or set -gx VISUAL hx

fish_add_path $SCRIPTS_DIR
test -s "$SCRIPTS_DIR/hooks/path.fish"; and source "$SCRIPTS_DIR/hooks/path.fish"
