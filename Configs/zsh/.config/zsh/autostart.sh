#!/usr/bin/env bash

# Runs all startup programs in background without terminal

# Load the PATH variable
HOME="${HOME:-/home/othman}"
source "${ZDOTDIR:-"${HOME}/.config/zsh"}/.zshenv"
source "${ZDOTDIR:-"${HOME}/.config/zsh"}/variables.sh"

# ---- Kill if already running ---- #
programs=(
  'copyq'
  'ollama'
  'sxhkd'
  '9router'
  'omniroute'
  # 'thunar'
  # 'dunst'
  # 'fcitx5'
)

killall -9 "${programs[@]}"

# ---- Disable power management ---- #
{
  sleep 1
  if [[ "${XDG_SESSION_TYPE}" == "x11" ]]; then
    xset s off
    xset s noblank
    xset -dpms
  fi
} &

# ---- Start CopyQ ---- #
if [[ -n "${DISPLAY}" || -n "${WAYLAND_DISPLAY}" ]]; then
  copyq --start-server &
else
  echo "No graphical display detected, skipping CopyQ."
fi

# ---- Start the ollama server ---- #
ollama serve &

# --- sxhkd for shortcuts --- #
sxhkd &

# Start DBus if not already running ---- #
if [[ -z "${DBUS_SESSION_BUS_ADDRESS}" ]]; then
  eval "$(dbus-launch --sh-syntax)"
  export DBUS_SESSION_BUS_ADDRESS
  export DBUS_SESSION_BUS_PID
fi

# ---- 9Router & Omniroute ---- #
if bun update -g 9router omniroute --latest || true; then
  {
    9router --tray --skip-update
    omniroute --tray --no-open --port 8082
  } &
fi

# ---- Start Spotify listener ---- #
# systemctl --user start spotify-listener &

# ---- Launch Polybar or Tint2 ---- #
# bash ~/.config/openbox/themes/launch-bar.sh

# ---- Notification Daemon ---- #
# dunst &

# ---- Thunar Daemon ---- #
# thunar --daemon &

# --- Start fcitx5 daemon --- #
# fcitx5 -d &

exit 0
