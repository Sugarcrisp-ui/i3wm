#!/usr/bin/env bash

# Author: Brett Crisp

declare -A colors=(
    [GREEN]='\033[0;32m'
    [BLUE]='\033[0;34m'
    [CYAN]='\033[0;36m'
    [YELLOW]='\033[0;33m'
    [RED]='\033[0;31m'
    [RESET]='\033[0m'
)

function log_message() {
    local COLOR=${1}
    shift
    local MSG="${*}"
    echo -e "${colors[$COLOR]}${MSG}${RESET}"
}

# Function to check if package is installed
is_package_installed() {
    pacman -Q "$1" &> /dev/null
}

# Function to install a package using paru (handles both official and AUR packages)
install_package() {
    if ! is_package_installed "$1"; then
        log_message "CYAN" "Installing: $1"
        if ! paru -S --noconfirm --needed "$1" &>/dev/null; then
            log_message "RED" "Failed to install $1"
            return 1
        fi
    else
        log_message "GREEN" "Already installed: $1"
    fi
    return 0
}

log_message "BLUE" "################################################################"
log_message "BLUE" "                    Installing Software Packages"
log_message "BLUE" "################################################################"

# Check if paru is installed
if ! command -v paru &> /dev/null; then
    log_message "RED" "paru is not installed. Please install it first to manage AUR packages."
    exit 1
fi

# Package lists
packages=(
    bluetooth-autoconnect
    insync-thunar
    joplin-appimage
    ttf-font-awesome-5
    videodownloader
)

# Install all packages
log_message "CYAN" "Installing packages..."
failed_packages=()
for package in "${packages[@]}"; do
    [[ $package == \#* ]] && continue  # skip commented packages
    if ! install_package "$package"; then
        failed_packages+=("$package")
    fi
done

if [ ${#failed_packages[@]} -gt 0 ]; then
    log_message "RED" "The following packages failed to install:"
    for fail in "${failed_packages[@]}"; do
        log_message "RED" "- $fail"
    done
fi

log_message "GREEN" "################################################################"
log_message "GREEN" "                    Software Installation Complete!"
log_message "GREEN" "################################################################"