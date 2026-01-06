#!/usr/bin/env bash
# shellcheck disable=2142

# ---- Aliases ----- #
alias zshrc='${EDITOR} ${ZSHRC}'
alias bashrc='$EDITOR ~/.bashrc'
alias art="php artisan"
alias cls="clear"
alias reload='source $ZSHRC && clear && neofetch'
alias pwdcp='clipcopy ${PWD}'
alias python="python3"
alias pip="pip3"
alias getgpu="lspci -k -d ::03xx"
alias path='printenv PATH | tr ":" "\n" | sed "s|$HOME|~|g" | no-dups | sort'

# ---- Bat (better cat) ----- #
alias -g -- --help='--help 2>&1 | command bat --language=help --style=plain --color=auto'
alias cat="command bat --paging=never --style=plain --color=auto"
alias catwhich="batwhich"

# ---- Zoxide (better cd) ----- #
alias cd="z"

# ---- Eza (better ls) ----- #
alias ls='SUDO_ASKPASS="${SCRIPTS_DIR}/echopass" sudo -A eza --all --color=always --long --git --icons=always --no-time --no-user --sort name --group-directories-first'
alias lsu='SUDO_ASKPASS="${SCRIPTS_DIR}/echopass" sudo -A eza --all --color=always --long --git --icons=always --no-time --sort name --group-directories-first'

alias lst='SUDO_ASKPASS="${SCRIPTS_DIR}/echopass" sudo -A eza -T --all --color=always --long --git --icons=always --no-time --no-user --sort name --ignore-glob="node_modules|.turbo|dist|build|.next|.nuxt|.git|vendor" --group-directories-first'
alias lstu='SUDO_ASKPASS="${SCRIPTS_DIR}/echopass" sudo -A eza -T --all --color=always --long --git --icons=always --no-time --sort name --ignore-glob="node_modules|.turbo|dist|build|.next|.nuxt|.git|vendor" --group-directories-first'

# ---- Micro (better nano) ----- #
alias nano="micro"
alias mc="micro"

# ---- Ripgrep (better grep) ----- #
alias grep="command rg -iNL"
alias rg="rg -iNL"

# ---- Lazygit ---- #
alias lzg="lazygit"

# ---- Adb ---- #
alias adb='HOME="$XDG_DATA_HOME"/android adb'

# ---- Nvidia settings ---- #
alias nvidia-settings='nvidia-settings --config="${XDG_CONFIG_HOME}/nvidia/settings"'

# ---- Svn ---- #
alias svn='svn --config-dir ${XDG_CONFIG_HOME}/subversion'

# --- Laravel Sail --- #
alias sail='sh $([ -f sail ] && echo sail || echo vendor/bin/sail)'

# ---- Wget ---- #
alias wget='wget --hsts-file="$XDG_DATA_HOME/wget-hsts"'

# ---- Confirm before overwriting something ---- #
alias cp="cp -iv"
alias mv="mv -iv"

# ---- Trash-cli (better rm & rmdir) ----- #
alias rm="rmtrash"
alias rmdir="rmdirtrash --ignore-fail-on-non-empty"

# ---- Easier to read disk ---- #
alias df='df -h'     # Disk usage per file system
alias dus='du -sh'   # Disk usage (summary)
alias free='free -m' # show sizes in MB

# ---- Get top process eating memory ---- #
alias psmem='n "ps | sort-by mem -r | first 5"'

# ---- Get top process eating cpu ---- #
alias pscpu='n "ps | sort-by cpu -r | first 5"'

#---- Git ---- #
alias git-init='git init && git add -A && git commit -m "initial commit"'
alias first-commit="git log --oneline | tail -1 | awk '{print \$1}'"
alias gca='git-commit --ai'
alias glg="git log --all --graph --pretty=format:'%C(magenta)%h%C(default) %an %C(yellow)%ar%C(auto) %D%n%s%n'"
alias gc="git clone"
alias glc='git pull origin $(git_current_branch)'
alias glo='git pull origin'
# --- aliases override --- #
unalias g &>/dev/null || true
unalias gcm &>/dev/null || true

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
[[ -n $(command -v n) ]] || alias n='nu --config ${NU_CONFIG} -c'

# ---- Capslock ---- #
alias caps="xdotool key Caps_Lock"
alias CAPS="xdotool key Caps_Lock"

# ---- Tokei ---- #
alias code-stats='tokei'

# ---- Distrobox ---- #
alias dbox='distrobox'

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

# --- Switch Branch --- #
alias sw='switch-branch'

# --- Mask (maskfile) --- #
if command -v mask &>/dev/null; then
  unalias mask &>/dev/null
  # shellcheck disable=2139
  alias task="$(command -v mask)"
  alias mask='mask --maskfile "$(git-root 2>/dev/null || pwd)/maskfile.md"'
fi

# --- diff --- #
alias diff='diff -u --color=auto'

# --- type --- #
alias type='type -a'

# --- Conky --- #
alias conky='conky --config="$XDG_CONFIG_HOME/conky/conkyrc"'

# --- SXHKD --- #
alias reload-sxhkd='pkill -USR1 -x sxhkd'

# --- ffmpeg --- #
alias ffmpeg='ffmpeg -hide_banner'

# --- shlorem --- #
alias lorem='shlorem'

# --- mancat --- #
alias mancat='man --pager="bat --paging=never --style=plain --color=auto --language=man"'
