if status is-interactive
    # Commands to run in interactive sessions can go here
end

starship init fish | source
enable_transience

set -gx SCRIPTS_DIR /home/othman/scripts
set -gx PATH $PATH $SCRIPTS_DIR

test -s "$SCRIPTS_DIR/hooks/path.fish"; and source "$SCRIPTS_DIR/hooks/path.fish"
