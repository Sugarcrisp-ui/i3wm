#!/bin/bash

# Function to switch to a workspace and start an application
# Arguments: <workspace_number> <command>
function start_app_on_workspace() {
  local workspace=$1
  local command=$2

  if ! pgrep -f "$command" >/dev/null; then
    i3-msg "workspace $workspace" >/dev/null
    sleep 1 # Give the workspace switch some time

    if ! pgrep -f "$command" >/dev/null; then
      # Start the application
      "$command" &

      # Wait for the application to start
      while ! pgrep -f "$command" >/dev/null; do
        sleep 1
      done
    fi

    # Check if the application is running on the workspace
    if wmctrl -l | grep -q " $workspace .* $command$"; then
      # The application is already running, do nothing
      return
    fi

    # Switch back to the original workspace
    i3-msg "workspace prev" >/dev/null
    sleep 1 # Give the workspace switch some time
  }
}

# Delay the script execution for 10 seconds
sleep 10

# Start Thunar on workspace 2
start_app_on_workspace 2 thunar

# Start Xfce Terminal on workspace 3
start_app_on_workspace 3 xfce4-terminal

# Start Messenger on workspace 4
start_app_on_workspace 4 "/home/brett/FacebookMessenger-linux-x64/FacebookMessenger"

# Start WhatsApp on workspace 4
start_app_on_workspace 4 "/home/brett/Whatsapp-linux-x64/Whatsapp"

# Start Google Chrome Stable on workspace 5
start_app_on_workspace 5 google-chrome-stable

# Start Firefox on workspace 1
start_app_on_workspace 1 firefox
