#!/usr/bin/env bash

set -eo pipefail

# ---  Main script logic --- #
STATE_DIR="/tmp/polybar-media"
STATE_FILE="${STATE_DIR}/state"

mkdir -p "${STATE_DIR}"

# --- Helper: safe ipc ---
ipc() {
  polybar-msg action "$1" &>/dev/null || true
}

# --- Detect player ---
status="$(playerctl status 2>/dev/null)" || status="none"

# --- No player: reset once ---
if [[ "$status" == "none" ]]; then
  if [[ -f "$STATE_FILE" ]] && grep -q '^active' "$STATE_FILE"; then
    ipc "#previous.hook.0"
    ipc "#next.hook.0"
    ipc "#playpause.hook.0"
    echo "none" >"$STATE_FILE"
  fi
  echo ""
  exit 0
fi

# --- Player active --- #
text="$(playerctl metadata --format '{{artist}} - {{title}}' 2>/dev/null)"
[[ -z "$text" ]] && exit 0

current_state="active|$status|$text"

# --- First run or changed state ---
if [[ ! -f "$STATE_FILE" ]] || [[ "$(cat "$STATE_FILE")" != "$current_state" ]]; then
  # Show controls
  ipc "#previous.hook.1"
  ipc "#next.hook.1"

  case "$status" in
  Playing) ipc "#playpause.hook.1" ;;
  Paused) ipc "#playpause.hook.2" ;;
  esac

  echo "$current_state" >"$STATE_FILE"
fi

# --- Output label (always) ---
/home/othman/scripts/trunc -l 35 -- "$text"
