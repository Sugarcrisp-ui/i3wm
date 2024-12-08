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

# Check if hblock is installed
if ! command -v hblock &>/dev/null; then
    log_message "RED" "hblock is not installed. Please install it before running this script."
    exit 1
fi

# Update hosts file
log_message "BLUE" "Starting Host File Update"
log_message "CYAN" "Running hblock to update system hosts file..."

if ! sudo hblock &>/dev/null; then
    log_message "RED" "Failed to update hosts file with hblock. Check if hblock is installed and has proper permissions."
    exit 1
else
    echo -e "${colors[GREEN]}Host file update completed successfully!${RESET}"
fi

log_message "GREEN" "Host File Protection Enabled"