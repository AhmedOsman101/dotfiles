#!/bin/sh

# ---- Aliases ----- #
alias zshrc="$EDITOR $ZSHRC"
alias bashrc="$EDITOR ~/.bashrc"
alias art="php artisan"
alias cls="clear"
alias reload="source $ZSHRC && clear && neofetch"
alias npm="pnpm"
alias vim="nvim"
# alias apt="nala" # For Ubuntu
alias python="python3"
alias pip="pip3"
alias getgpu="lspci -k -d ::03xx"

# ---- Bat (better cat) ----- #
alias cat="bat --pager never --style plain"
alias -g -- -h='-h 2>&1 | bat --language=help --style=plain'
alias -g -- --help='--help 2>&1 | bat --language=help --style=plain'

# ---- Zoxide (better cd) ----- #
alias cd="z"

# ---- Eza (better ls) ----- #
alias ls="eza  --all --color=always --long --git --icons=always --no-time --no-user --sort name"

# ---- Micro (better nano) ----- #
alias nano="micro"
alias mc="micro"

# ---- Ripgrep (better grep) ----- #
alias grep="rg"
alias rg="rg -i"

# ---- Lazygit ---- #
alias lzg="lazygit"

# ---- Adb ---- #
alias adb='HOME="$XDG_DATA_HOME"/android adb'

# ---- Nvidia settings ---- #
alias nvidia-settings="nvidia-settings --config="$XDG_CONFIG_HOME"/nvidia/settings"

# ---- Svn ---- #
alias svn="svn --config-dir $XDG_CONFIG_HOME/subversion"

# ---- Wget ---- #
alias wget=wget --hsts-file="$XDG_DATA_HOME/wget-hsts"

# ---- Confirm before overwriting something ---- #
alias cp="cp -i"
alias mv="mv -i"

# ---- Trash-cli (better rm & rmdir) ----- #
alias rm="rmtrash"
alias rmdir="rmdirtrash --ignore-fail-on-non-empty"

# ---- Easier to read disk ---- #
alias df='df -h'     # human-readable sizes
alias free='free -m' # show sizes in MB

# ---- Get top process eating memory ---- #
alias psmem='ps aux | sort -nr -k 4 | head -5 | fzf'

# ---- Get top process eating cpu ---- #
alias pscpu='ps aux | sort -nr -k 3 | head -5 | fzf'

#---- Git ---- #
alias git_current_branch='git branch --show-current 2>/dev/null'
alias gits="git status --short"

# ---- Copy to Clipboard ----#
[[ $(command -v copyclip) ]] || alias copyclip="clipcopy"

# ---- Qalculate ---- #
alias qalc="qalc --color" # Colorize output
alias calc="qalc --terse" # Return only the output and colorize output

# ---- Helix ---- #
alias hlx="helix"
