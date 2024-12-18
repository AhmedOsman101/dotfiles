#!/usr/bin/env bash

## Copyright (C) 2020-2024 Aditya Shakya <adi1090x@gmail.com>

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
CARD="$(light -L | grep 'backlight' | head -n1 | cut -d'/' -f3)"
INTERFACE="$(ip route get 1.1.1.1 | awk '{print $5;exit}')"
BAT="$(acpi -b)"
RFILE="$DIR/.module"

# Fix backlight and network modules
fix_modules() {
	local patterns=("dot" "dot-alt" "LD" "RD") # Define patterns to be removed around target words
	local pattern_regex=""

	if [[ ${#patterns[@]} -gt 0 ]]; then
		pattern_regex="(\\.?|$(
			IFS="|"
			echo "${patterns[*]}"
		))"
	fi

	if [[ -z "$CARD" || "$CARD" != "No backlight controller was found"* ]]; then
		# sed -i -e 's/backlight/bna/g' "$DIR"/config.ini
		sed -i -E "s/${pattern_regex}(backlight)${pattern_regex}/bna/g" "$DIR"/config.ini
	elif [[ "$CARD" != *"intel_"* ]]; then
		# sed -i -e 's/backlight/brightness/g' "$DIR"/config.ini
		sed -i -E "s/${pattern_regex}(brightness)${pattern_regex}/brightness/g" "$DIR"/config.ini
	fi

	if [[ -z "$BAT" ]]; then
		# sed -i -e 's/battery/btna/g' "$DIR"/config.ini
		sed -i -E "s/${pattern_regex}(battery)${pattern_regex}/btna/g" "$DIR"/config.ini
	fi

	if [[ "$INTERFACE" == e* ]]; then
		# sed -i -e 's/ethernet/g' "$DIR"/config.ini
		sed -i -E "s/${pattern_regex}(ethernet)${pattern_regex}//g" "$DIR"/config.ini
	fi

	if [[ "$INTERFACE" == w* ]]; then
		# sed -i -e 's/network/g' "$DIR"/config.ini
		sed -i -E "s/${pattern_regex}(network)${pattern_regex}//g" "$DIR"/config.ini
	fi
}

# Launch the bar
launch_bar() {
	# Terminate already running bar instances
	killall -q polybar

	# Wait until the processes have been shut down
	while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

	# Launch the bar
	for mon in $(polybar --list-monitors | cut -d":" -f1); do
		MONITOR=$mon polybar -q main -c "$DIR"/config.ini &
	done
}

# Execute functions
if [[ ! -f "$RFILE" ]]; then
	fix_modules
	touch "$RFILE"
fi
launch_bar
