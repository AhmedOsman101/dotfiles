#!/usr/bin/env zsh

# ---- Aliases ----- #
alias zshrc="$EDITOR $ZSHRC"
alias bashrc="$EDITOR ~/.bashrc"
alias art="php artisan"
alias cls="clear"
alias reload="source $ZSHRC && cls && neofetch"
alias vim="nvim"
alias pwdcp='clipcopy ${PWD}'
alias python="python3"
alias pip="pip3"
alias getgpu="lspci -k -d ::03xx"

# ---- Bat (better cat) ----- #
alias -g -- --help='--help 2>&1 | bat --language=help --style=plain --color=auto'
alias cat="bat --pager never --style=plain --color=auto"

# ---- Zoxide (better cd) ----- #
alias cd="z"

# ---- Eza (better ls) ----- #
alias ls='SUDO_ASKPASS="${SCRIPTS_DIR}/echopass" sudo -A eza --all --color=always --long --git --icons=always --no-time --no-user --sort name'
alias lsu='SUDO_ASKPASS="${SCRIPTS_DIR}/echopass" sudo -A eza --all --color=always --long --git --icons=always --no-time --sort name'

alias lst='SUDO_ASKPASS="${SCRIPTS_DIR}/echopass" sudo -A eza -T --all --color=always --long --git --icons=always --no-time --no-user --sort name --ignore-glob="node_modules|.turbo|dist|build|.next|.nuxt|.git|vendor"'
alias lstu='SUDO_ASKPASS="${SCRIPTS_DIR}/echopass" sudo -A eza -T --all --color=always --long --git --icons=always --no-time --sort name --ignore-glob="node_modules|.turbo|dist|build|.next|.nuxt|.git|vendor"'

# ---- Micro (better nano) ----- #
alias nano="micro"
alias mc="micro"

# ---- Ripgrep (better grep) ----- #
alias grep="rg -iNL"
alias rg="rg -iNL"

# ---- Lazygit ---- #
alias lzg="lazygit"

# ---- Adb ---- #
alias adb='HOME="$XDG_DATA_HOME"/android adb'

# ---- Nvidia settings ---- #
alias nvidia-settings="nvidia-settings --config="$XDG_CONFIG_HOME"/nvidia/settings"

# ---- Svn ---- #
alias svn="svn --config-dir $XDG_CONFIG_HOME/subversion"

# --- Laravel Sail --- #
alias sail='sh $([ -f sail ] && echo sail || echo vendor/bin/sail)'

# ---- Wget ---- #
alias wget='wget --hsts-file="$XDG_DATA_HOME/wget-hsts"'

# ---- Confirm before overwriting something ---- #
alias cp="cp -i"
alias mv="mv -i"

# ---- Trash-cli (better rm & rmdir) ----- #
alias rm="rmtrash"
alias rmdir="rmdirtrash --ignore-fail-on-non-empty"

# ---- Easier to read disk ---- #
alias df='df -h'     # human-readable sizes
alias dus='du -sh'   # human-readable sizes
alias du='du -h'     # human-readable sizes
alias free='free -m' # show sizes in MB

# ---- Get top process eating memory ---- #
alias psmem='n "ps | sort-by mem -r | first 5"'

# ---- Get top process eating cpu ---- #
alias pscpu='n "ps | sort-by cpu -r | first 5"'

#---- Git ---- #
alias git-init='git init && git add -A && git commit -m "initial commit"'

# ---- Copy to Clipboard ----#
[[ -n $(command -v copyclip) ]] || alias copyclip="clipcopy"

# ---- Qalculate ---- #
alias calc="qalc --base 10 --color --terse" # Return only the output and colorize output
alias qalc="qalc --base 10 --color"         # Colorize output

# ---- Pacman ---- #
# Resolve 'pacman in use' error
alias freepacman="sudo rm /var/lib/pacman/db.lck &>/dev/null || true"

# --- Frogmouth Markdown Preview ---- #
alias frg="frogmouth"

# ---- Doas ---- #
alias doas="doas --"

# ---- Mirrorlist ---- #
alias mirror="sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist" # Fastest mirrors

# ---- Cargo ---- #
alias cb="cargo build"

# ---- Nushell ---- #
[[ -n $(command -v n) ]] || alias n="nu --config $NU_CONFIG -c"

# ---- Capslock ---- #
alias caps="xdotool key Caps_Lock"
alias CAPS="xdotool key Caps_Lock"

# ---- Tokei ---- #
alias code-stats='tokei'

# ---- Distrobox ---- #
alias db='distrobox'

# ---- Shutdown (safely) ---- #
alias goodnight='sync && sudo systemctl poweroff'
alias goodnights='SUDO_ASKPASS="${SCRIPTS_DIR}/echopass" sudo -A sync && SUDO_ASKPASS="${SCRIPTS_DIR}/echopass" sudo -A systemctl poweroff'

# ---- Reboot (safely) ---- #
alias restart='sync && sudo systemctl reboot'
alias restarts='SUDO_ASKPASS="${SCRIPTS_DIR}/echopass" sudo -A sync && SUDO_ASKPASS="${SCRIPTS_DIR}/echopass" sudo -A systemctl reboot'

# ---- Rtx (asdf rust clone) ---- #
alias asdf='rtx'

# ---- PNPM ---- #
alias pnpx='pnpm dlx'
alias npx='pnpm dlx'

# ---- Standard-version ---- #
alias stdver='standard-version'

# ---- Release Please ---- #
alias rp='release-please'

# --- MySql --- #
alias mysql='mariadb'

# --- Vite --- #
alias vite="vite --config ${XDG_CONFIG_HOME}/vite/vite.config.js"

# --- Switch Branch --- #
alias sw='switch-branch'

# --- Mask (maskfile) --- #
unalias mask &>/dev/null
alias task="$(which mask)"
alias mask='mask --maskfile "$(git-root 2>/dev/null || pwd)/maskfile.md"'

# --- diff --- #
alias diff='diff -u --color=auto'

# --- type --- #
alias type='type -a'

# --- Conky --- #
alias conky='conky --config="$XDG_CONFIG_HOME"/conky/conkyrc'

alias xbindkeys='xbindkeys -f "$XDG_CONFIG_HOME/xbindkeys/config"'
