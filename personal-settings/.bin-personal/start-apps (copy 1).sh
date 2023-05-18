#!/bin/bash

# Function to switch to a workspace and start an application
# Arguments: <workspace_number> <command>
function start_app_on_workspace() {
  local workspace=$1
  local command=$2

  if ! wmctrl -l | grep -q " $workspace .* $(basename "$command")$"; then
    i3-msg "workspace $workspace" >/dev/null
    sleep 2 # Give the workspace switch some time

    if ! wmctrl -l | grep -q " $workspace .* $(basename "$command")$"; then
      # Start the application
      exec "$command" &
    fi

    # Wait for the application to start
    sleep 3

    # Check if the application window exists on the workspace
    if wmctrl -l | grep -q " $workspace .* $(basename "$command")$"; then
      # The application window exists, do nothing
      return
    fi
  fi
}

# Start Firefox on workspace 1 only if it's not already running
if ! pgrep -x firefox >/dev/null; then
  start_app_on_workspace 1 firefox
else
  echo "Firefox is already running on workspace 1, not starting new instance"
fi

# Start Thunar on workspace 2 only if it's not already running
if ! pgrep -x thunar >/dev/null; then
  start_app_on_workspace 2 thunar
else
  echo "Thunar is already running on workspace 2, not starting new instance"
fi

# Start Xfce Terminal on workspace 3
start_app_on_workspace 3 xfce4-terminal

# Start Messenger on workspace 4
start_app_on_workspace 4 "/home/brett/FacebookMessenger-linux-x64/FacebookMessenger"

# Start WhatsApp on workspace 4
start_app_on_workspace 4 "/home/brett/Whatsapp-linux-x64/Whatsapp"

# Start Google Chrome Stable on workspace 5
start_app_on_workspace 5 google-chrome-stable

# Switch to workspace 1
i3-msg "workspace 1" >/dev/null
