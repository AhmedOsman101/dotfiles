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

# ---- Add in zsh plugins ---- #
zinit light Aloxaf/fzf-tab
zinit light zdharma-continuum/fast-syntax-highlighting
zinit light "MichaelAquilina/zsh-you-should-use"
zinit light "AhmedOsman101/zsh-auto-notify-fork"
zinit light zsh-users/zsh-completions
# zinit light "marlonrichert/zsh-autocomplete"
zinit light hlissner/zsh-autopair
zinit light zsh-users/zsh-autosuggestions
zinit light larkery/zsh-histdb

# Load a few important annexes, without Turbo
zinit light-mode for \
  zdharma-continuum/zinit-annex-as-monitor \
  zdharma-continuum/zinit-annex-bin-gem-node \
  zdharma-continuum/zinit-annex-patch-dl \
  zdharma-continuum/zinit-annex-rust

# ---- Add in snippets ---- #
zinit snippet OMZP::git
zinit snippet OMZP::command-not-found
zinit snippet OMZP::copyfile
zinit snippet OMZP::copypath
zinit snippet OMZP::dirhistory
zinit snippet OMZP::extract

# --- Open buffer line editor --- #
autoload -Uz edit-command-line

# --- ZMV advanced file move --- #
autoload zmv

# --- run-help will use man instead of less --- #
autoload -Uz run-help
unalias run-help &>/dev/null

# --- Enable binding functions to hooks --- #
autoload -Uz add-zsh-hook
