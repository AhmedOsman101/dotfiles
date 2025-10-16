#!/usr/bin/env bash

# Run all startup programs in background without terminal

# ---- Kill if already running ---- #
programs=(
	copyq
	ollama
	sxhkd
	# thunar
	# dunst
	# fcitx5
)

killall -9 "${programs[@]}"

# ---- Disable power management ---- #
(sleep 1 && xset s off && xset s noblank && xset -dpms) &

# ---- Start copyq server ---- #
exec copyq --start-server &

# ---- Start the ollama server ---- #
exec ollama serve &

# --- sxhkd for shortcuts --- #
exec sxhkd &

# Start DBus if not already running ---- #
if [[ -z "${DBUS_SESSION_BUS_ADDRESS}" ]]; then
	eval "$(dbus-launch --sh-syntax)"
	export DBUS_SESSION_BUS_ADDRESS
	export DBUS_SESSION_BUS_PID
fi

# ---- Start Spotify listener ---- #
# systemctl --user start spotify-listener &

# ---- Launch Polybar or Tint2 ---- #
# bash ~/.config/openbox/themes/launch-bar.sh

# ---- Notification Daemon ---- #
# exec dunst &

# ---- Thunar Daemon ---- #
# exec thunar --daemon &

# --- Start fcitx5 daemon --- #
# exec fcitx5 -d &

exit 0
