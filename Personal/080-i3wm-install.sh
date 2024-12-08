#!/usr/bin/env bash

# Author: Brett Crisp
# Improved i3 installation script with error tracking and enhanced maintainability.

declare -A colors=(
    [GREEN]="$(tput setaf 2)"
    [BLUE]="$(tput setaf 4)"
    [CYAN]="$(tput setaf 6)"
    [RED]="$(tput setaf 1)"
    [RESET]="$(tput sgr0)"
)

function log_message() {
    local COLOR=${1}
    shift
    local MSG="${*}"
    echo -e "${colors[$COLOR]}${MSG}${RESET}"
}

# Check if a package is installed
function is_installed() {
    pacman -Qi "$1" &> /dev/null
}

# Install a package if not installed
function install_package() {
    if ! is_installed "$1"; then
        log_message "CYAN" "Installing: $1"
        if ! output=$(sudo pacman -S --noconfirm --needed "$1" 2>&1); then
            log_message "RED" "Failed to install: $1 - Error: $output"
            failed_packages+=("$1")
            return 1
        fi
    else
        log_message "GREEN" "Already installed: $1"
    fi
}

# Validate internet connection
function check_internet() {
    if ! timeout 5s ping -c 1 archlinux.org &>/dev/null; then
        log_message "RED" "Error: Internet connection is required."
        exit 1
    fi
}

# Print header
log_message "BLUE" "################################################################"
log_message "BLUE" "                    Installing i3 Window Manager"
log_message "BLUE" "################################################################"

# Check internet connection
check_internet

# Core i3 packages with descriptions
declare -A i3_packages=(
    # ... your package definitions here ...
)

# Install packages
log_message "CYAN" "Installing i3 packages..."
total=${#i3_packages[@]}
current=0
failed_packages=()

# Installation loop
for package in "${!i3_packages[@]}"; do
    ((current++))
    log_message "BLUE" "[${current}/${total}] Processing: ${package} - ${i3_packages[$package]}"
    install_package "$package"
done

# Report failed installations
if [[ ${#failed_packages[@]} -gt 0 ]]; then
    log_message "RED" "The following packages failed to install:"
    for pkg in "${failed_packages[@]}"; do
        log_message "RED" "  - $pkg"
    done
    exit 1
else
    log_message "GREEN" "All packages installed successfully."
fi

log_message "GREEN" "################################################################"
log_message "GREEN" "                    i3 Installation Complete!"
log_message "GREEN" "################################################################"