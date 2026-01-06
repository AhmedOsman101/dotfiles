#!/usr/bin/env bash

# ---- Rehash Zsh only when pacman updates /usr/bin ---- #
# Triggered by /usr/share/libalpm/hooks/archcraft-hook-zsh.hook
zshcache_time="$(date +%s%N)"
autoload -Uz add-zsh-hook
add-zsh-hook -Uz precmd rehash_precmd

rehash_precmd() {
	local paccache_time
	if [[ -e /var/cache/zsh/pacman ]]; then
		paccache_time="$(date -r /var/cache/zsh/pacman +%s%N)"
		if ((zshcache_time < paccache_time)); then
			rehash
			zshcache_time="${paccache_time}"
		fi
	fi
}

# Runs before any command
# precmd() { :; }

# Runs when changing directories
# chpwd() { :; }

# Runs after any command
# preexec() { :; }
