#!/usr/bin/env bash

# Author: Brett Crisp

declare -A colors=(
    [GREEN]="$(tput setaf 2)"
    [BLUE]="$(tput setaf 4)"
    [CYAN]="$(tput setaf 6)"
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

log_message "BLUE" "                    Setting Up Autostart Applications"

# Check if source directory exists
if [ ! -d "~/i3wm/personal-settings/autostart" ]; then
    log_message "RED" "Source autostart directory not found"
    exit 1
fi

# Create autostart directory if it doesn't exist
if ! mkdir -p "$HOME/.config/autostart"; then
    log_message "RED" "Failed to create autostart directory"
    exit 1
fi

# Copy autostart files
log_message "CYAN" "Copying autostart configurations..."
if ! cp -Rf ~/i3wm/personal-settings/autostart/* ~/.config/autostart/; then
    log_message "RED" "Failed to copy autostart configurations"
    exit 1
fi

log_message "GREEN" "                    Autostart Applications Configured!"