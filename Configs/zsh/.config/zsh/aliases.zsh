#!/bin/sh

# ---- Aliases ----- #
alias zshrc="micro $ZDOTDIR/.zshrc"
alias bashrc="micro ~/.bashrc"
alias art="php artisan"
alias cls="clear"
alias reload="source $ZDOTDIR/.zshrc && clear && neofetch"
alias npm="pnpm"
alias vim="nvim"
alias apt="nala"
alias python="python3"
alias pip="pip3"
alias getgpu="lspci -k -d ::03xx"
alias ocr="tesseract"
# ---- Zoxide (better cd) ----- #
alias cd="z"
# ---- Eza (better ls) ----- #
alias ls="eza  --all --color=always --long --git --icons=always --no-time --no-user --sort name"
# ---- Micro (better nano) ----- #
alias nano="micro"
alias mc="micro"
# ---- ripgrep (better grep) ----- #
alias grep="rg"
alias lzg="lazygit"
# ---- adb ---- #
alias adb='HOME="$XDG_DATA_HOME"/android adb'
# ---- Nvidia settings ---- #
alias nvidia-settings="nvidia-settings --config="$XDG_CONFIG_HOME"/nvidia/settings"
# ---- Svn ---- #
alias svn="svn --config-dir $XDG_CONFIG_HOME/subversion"
# ---- Wget ---- #
alias wget=wget --hsts-file="$XDG_DATA_HOME/wget-hsts"

# ---- confirm before overwriting something ---- #
alias cp="cp -i"
alias mv="mv -i"
# ---- Trash-cli (better rm & rmdir) ----- #
alias rm="rmtrash -i"
alias rmdir="rmdirtrash -i"

# ---- easier to read disk ---- #
alias df='df -h'     # human-readable sizes
alias free='free -m' # show sizes in MB

# ---- get top process eating memory ---- #
alias psmem='ps aux | sort -nr -k 4 | head -5 | fzf'

# ---- get top process eating cpu ---- #
alias pscpu='ps aux | sort -nr -k 3 | head -5 | fzf'
