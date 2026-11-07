# Ryoku palette for fish and fzf. Rendered by the theme daemon; do not edit.
#
# Dropped straight into conf.d, which fish sources on its own, so nothing in the
# shipped config has to include it. Your ~/.config/fish/user.fish loads last and
# still wins.

# Syntax highlighting.
set -g fish_color_normal e3e1e9
set -g fish_color_command bac3ff
set -g fish_color_keyword e5bad8
set -g fish_color_quote c3c5dd
set -g fish_color_redirection c6c5d0
set -g fish_color_end e5bad8
set -g fish_color_error ffb4ab
set -g fish_color_param e3e1e9
set -g fish_color_comment c6c5d0
set -g fish_color_selection --background=394379
set -g fish_color_operator e5bad8
set -g fish_color_escape c3c5dd
set -g fish_color_autosuggestion c6c5d0
set -g fish_color_cancel ffb4ab
set -g fish_color_search_match --background=394379
set -g fish_color_valid_path --underline

# Completion pager.
set -g fish_pager_color_progress c6c5d0
set -g fish_pager_color_prefix bac3ff
set -g fish_pager_color_completion e3e1e9
set -g fish_pager_color_description c6c5d0
set -g fish_pager_color_selected_background --background=394379

# fzf takes the same palette, so Ctrl-R and Ctrl-T match the terminal they open
# in. Appended to whatever options are already set rather than replacing them.
set -gx FZF_DEFAULT_OPTS "$FZF_DEFAULT_OPTS \
--color=fg:#e3e1e9,bg:-1,hl:#bac3ff \
--color=fg+:#e3e1e9,bg+:#394379,hl+:#bac3ff \
--color=info:#c3c5dd,prompt:#bac3ff,pointer:#e5bad8 \
--color=marker:#e5bad8,spinner:#c3c5dd,header:#c6c5d0 \
--color=border:#46464f"
