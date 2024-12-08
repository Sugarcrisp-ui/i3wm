#!/usr/bin/env bash

# Author: Brett Crisp

declare -A colors=(
    [GREEN]="$(tput setaf 2)"
    [BLUE]="$(tput setaf 4)"
    [CYAN]="$(tput setaf 6)"
    [YELLOW]="$(tput setaf 3)"
    [RESET]="$(tput sgr0)"
)

function log_message() {
    local COLOR=${1}
    shift
    local MSG="${*}"
    echo -e "${colors[$COLOR]}################################################################${RESET}"
    echo -e "${colors[$COLOR]}${MSG}${RESET}"
    echo -e "${colors[$COLOR]}################################################################${RESET}"
}

# Check if root is using BTRFS
FILESYSTEM=$(df -T / | awk 'NR==2 {print $2}')

if [ "$FILESYSTEM" != "btrfs" ]; then
    log_message "YELLOW" "System not using BTRFS - Skipping setup"
    exit 0
fi

log_message "BLUE" "                    Setting Up BTRFS Configuration"

# Check if source directory exists
if [ ! -d "~/i3wm/personal-settings/autostart" ]; then
    log_message "RED" "Source autostart directory for BTRFS not found"
    exit 1
fi

# Create autostart directory
if ! mkdir -p "$HOME/.config/autostart"; then
    log_message "RED" "Failed to create autostart directory"
    exit 1
fi

# Copy BTRFS autostart configurations
log_message "CYAN" "Copying BTRFS configurations..."
if ! cp -Rf ~/i3wm/personal-settings/autostart/* ~/.config/autostart/; then
    log_message "RED" "Failed to copy BTRFS configurations"
    exit 1
fi

log_message "GREEN" "                    BTRFS Setup Complete!"