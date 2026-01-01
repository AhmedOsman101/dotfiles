#!/usr/bin/env bash

## Copyright (C) 2020-2024 Aditya Shakya <adi1090x@gmail.com>

## Files and Directories
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
SFILE="$DIR/system.ini"
RFILE="$DIR/.system"
STYLE="default"

## Get system variable values for various modules
get_values() {
  CARD=$(light -L 2>&1 | grep -v "No backlight" | grep 'backlight' | head -n1 | cut -d'/' -f3)
  BATTERY=$(upower -i "$(upower -e | grep 'BAT')" | grep 'native-path' | cut -d':' -f2 | tr -d '[:blank:]')
  ADAPTER=$(upower -i "$(upower -e | grep 'AC')" | grep 'native-path' | cut -d':' -f2 | tr -d '[:blank:]')
  INTERFACE="$(net-interface)"
}

## Write values to `system.ini` file
set_values() {
  if [[ -n "$ADAPTER" ]]; then
    sed -i -e "s/sys_adapter = .*/sys_adapter = $ADAPTER/g" "${SFILE}"
  fi
  if [[ -n "$BATTERY" ]]; then
    sed -i -e "s/sys_battery = .*/sys_battery = $BATTERY/g" "${SFILE}"
  fi
  if [[ -n "$CARD" ]]; then
    sed -i -e "s/sys_graphics_card = .*/sys_graphics_card = $CARD/g" "${SFILE}"
  fi
  if [[ -n "$INTERFACE" ]]; then
    sed -e "s|sys_network_interface = .*|sys_network_interface = ${INTERFACE}|g" -i "${SFILE}"
  fi
}

## Launch Polybar with selected style
launch_bar() {
  PATH="${PATH}:${HOME}/scripts" bash "$HOME"/.config/openbox/themes/"$STYLE"/polybar/launch.sh
}

# Execute functions
if [[ ! -f "$RFILE" ]]; then
  touch "${RFILE}"
fi

get_values
set_values
launch_bar
