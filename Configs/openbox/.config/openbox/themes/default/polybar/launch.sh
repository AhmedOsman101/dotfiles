#!/usr/bin/env bash

## Copyright (C) 2020-2024 Aditya Shakya <adi1090x@gmail.com>

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
CARD="$(light -L 2>&1 | grep -v "No backlight" | grep 'backlight' | head -n1 | cut -d'/' -f3)"
INTERFACE="$(net-interface)"
BAT="$(acpi -b)"
RFILE="$DIR/.module"

# Fix backlight and network modules
fix_modules() {
  if [[ -z "$CARD" ]]; then
    sed -i -e 's/backlight/bna/g' "$DIR"/config.ini
  elif [[ "$CARD" != *"intel_"* ]]; then
    sed -i -e 's/backlight/brightness/g' "$DIR"/config.ini
  fi

  if [[ -z "$BAT" ]]; then
    sed -i -e 's/battery/btna/g' "$DIR"/config.ini
  fi

  if [[ "$INTERFACE" == e* ]]; then
    sed -i -e 's/network/ethernet/g' "$DIR"/config.ini
  else
    sed -i -e 's/ethernet/network/g' "$DIR"/config.ini
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
