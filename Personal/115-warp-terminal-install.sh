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
    echo -e "${colors[$COLOR]}${MSG}${RESET}"
}

# Download and installation paths
DOWNLOAD_DIR="$HOME/Downloads"
DOWNLOAD_URL="https://app.warp.dev/download?package=pacman"
PACKAGE_NAME="warp-terminal.pkg.tar.zst"

log_message "BLUE" "################################################################"
log_message "BLUE" "                Installing Warp Terminal"
log_message "BLUE" "################################################################"

# Check if Warp Terminal is already installed
if pacman -Qi warp-terminal &>/dev/null; then
    log_message "GREEN" "Warp Terminal is already installed."
    exit 0
fi

# Ensure download directory exists
mkdir -p "$DOWNLOAD_DIR"

# Download Warp Terminal
log_message "CYAN" "Downloading Warp Terminal..."
if ! curl -L -o "$DOWNLOAD_DIR/$PACKAGE_NAME" "$DOWNLOAD_URL"; then
    log_message "RED" "Failed to download Warp Terminal."
    exit 1
fi

# Install package
log_message "CYAN" "Installing Warp Terminal..."
if ! pacman -U --noconfirm "$DOWNLOAD_DIR/$PACKAGE_NAME" &>/dev/null; then
    log_message "RED" "Failed to install Warp Terminal."
    exit 1
fi

# Cleanup
log_message "CYAN" "Cleaning up downloaded files..."
if ! rm "$DOWNLOAD_DIR/$PACKAGE_NAME"; then
    log_message "YELLOW" "Failed to remove downloaded package, consider manual cleanup."
fi

log_message "GREEN" "################################################################"
log_message "GREEN" "                Warp Terminal Installation Complete!"
log_message "GREEN" "################################################################"