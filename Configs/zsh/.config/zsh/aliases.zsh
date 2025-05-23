#!/bin/sh

# ---- Aliases ----- #
alias zshrc="$EDITOR $ZSHRC"
alias bashrc="$EDITOR ~/.bashrc"
alias art="php artisan"
alias cls="clear"
alias reload="source $ZSHRC && clear && neofetch"
alias vim="nvim"
alias pwdcp='clipcopy ${PWD}'
alias python="python3"
alias pip="pip3"
alias getgpu="lspci -k -d ::03xx"

# ---- Bat (better cat) ----- #
alias cat="bat --pager never --style plain"
alias -g -- --help='--help 2>&1 | bat --language=help --style=plain'

# ---- Zoxide (better cd) ----- #
alias cd="z"

# ---- Eza (better ls) ----- #
alias ls="eza  --all --color=always --long --git --icons=always --no-time --no-user --sort name"

# ---- Micro (better nano) ----- #
alias nano="micro"
alias mc="micro"

# ---- Ripgrep (better grep) ----- #
alias grep="rg -iN"
alias rg="rg -iN"

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
alias psmem='n "ps | sort-by mem | last 5"'

# ---- Get top process eating cpu ---- #
alias pscpu='n "ps | sort-by cpu | last 5"'

#---- Git ---- #
[[ -n $(command -v git_current_branch) ]] ||
  alias git_current_branch='git branch --show-current 2>/dev/null'

# ---- Copy to Clipboard ----#
[[ -n $(command -v copyclip) ]] || alias copyclip="clipcopy"

# ---- Qalculate ---- #
alias calc="qalc --base 10 --color --terse" # Return only the output and colorize output
alias qalc="qalc --base 10 --color"         # Colorize output

# ---- Pacman ---- #
# Resolve 'pacman in use' error
alias freepacman="sudo rm /var/lib/pacman/db.lck &>/dev/null || printf ''"

# ---- Paru ---- #
alias no-orphans='paru -Rns $(paru -Qtdq)'

# --- Frogmouth Markdown Preview ---- #
alias frg="frogmouth"

# ---- Doas ---- #
alias doas="doas --"

# ---- Mirrorlist ---- #
alias mirror="sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist" # Fastest mirrors

# ---- Cargo ---- #
alias cr="cargo run"
alias cb="cargo build"

# ---- Nushell ---- #
alias n="nu --config $NU_CONFIG -c"

# ---- Capslock ---- #
alias caps="xdotool key Caps_Lock"
alias CAPS="xdotool key Caps_Lock"

# ---- Tokei ---- #
alias code-stats='tokei'

# ---- Distrobox ---- #
alias db='distrobox'

# ---- Shutdown (safely) ---- #
alias goodnight='sync && sudo systemctl poweroff'
