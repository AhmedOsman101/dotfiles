#!/usr/bin/env bash

# ---- Add in zsh prompt ---- #
autoload -Uz promptinit
promptinit

# ---- Prompt Starship ---- #
if command -v starship &>/dev/null; then
  eval "$(starship init zsh)"
else
  zinit ice as"command" from"gh-r" \
    atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
    atpull"%atclone" src"init.zsh"
  zinit light starship/starship
fi

# ---- Add zsh Plugins ---- #
zinit light 'Aloxaf/fzf-tab'                             # fzf-powered tab completion
zinit light 'zdharma-continuum/fast-syntax-highlighting' # Fast async syntax highlighting
zinit light 'MichaelAquilina/zsh-you-should-use'         # Suggest existing aliases
zinit light 'AhmedOsman101/zsh-auto-notify-fork'         # Notify on long commands
zinit light 'zsh-users/zsh-completions'                  # Extra completion defs
zinit light 'hlissner/zsh-autopair'                      # Auto-close brackets/quotes
zinit light 'AhmedOsman101/archlinux-zsh-plugin'         # Useful package manager commands
zinit light 'zsh-users/zsh-autosuggestions'              # History-based suggestions
zinit light 'olets/zsh-transient-prompt'                 # Transient prompt for zsh
# zinit light 'larkery/zsh-histdb'                         # SQLite-backed history

# Load a few important annexes, without Turbo
zinit light-mode for \
  zdharma-continuum/zinit-annex-as-monitor \
  zdharma-continuum/zinit-annex-bin-gem-node \
  zdharma-continuum/zinit-annex-patch-dl \
  zdharma-continuum/zinit-annex-rust

# ---- Add in snippets ---- #
zinit snippet OMZP::git          # Git aliases & helpers
zinit snippet OMZP::dirhistory   # Alt+ <- / Alt+ -> directory navigation
zinit snippet OMZP::extract      # `x` -> extract any archive
zinit snippet OMZP::encode64     # Encoding or decoding using base64 command (e64, ef64, d64)
zinit snippet OMZP::fancy-ctrl-z # Allows pressing Ctrl-Z again to switch back to a background job
zinit snippet OMZP::copypath     # Copies the path of given directory or file to the system clipboard
zinit snippet OMZP::gh           # Adds completion for the GitHub CLI
zinit snippet OMZP::gitignore    # Various .gitignore templates
zinit snippet OMZP::gpg-agent    # fixes for some common issues encountered with gpg-agent
zinit snippet OMZP::qrcode       # Generate a QR Code from the command line
zinit snippet OMZP::rsync        # Aliases for rsync (rsync-{copy,move,update,synchronize})
zinit snippet OMZP::rust         # Completions for rust toolchain
zinit snippet OMZP::alias-finder # Suggest existing aliases for commands
zinit snippet OMZP::aliases      # Search all aliases by group
# zinit snippet OMZP::safe-paste        # Preventing any code from actually running while pasting
# zinit snippet OMZP::command-not-found # Suggest packages for missing commands

# --- Open buffer line editor --- #
autoload -Uz edit-command-line

# --- ZMV advanced file move --- #
autoload zmv

# --- run-help will use man instead of less --- #
autoload -Uz run-help
unalias run-help &>/dev/null

# --- Enable binding functions to hooks --- #
autoload -Uz add-zsh-hook
