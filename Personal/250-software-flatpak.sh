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

# Flatpak packages
packages=(
    com.protonvpn.www
)

function install_flatpak() {
    if ! flatpak list | grep -q "$1"; then
        log_message "CYAN" "Installing: $1"
        if ! flatpak install -y flathub "$1" &>/dev/null; then
            log_message "RED" "Failed to install: $1"
            return 1
        fi
    else
        log_message "GREEN" "Already installed: $1"
    fi
    return 0
}

log_message "BLUE" "################################################################"
log_message "BLUE" "                    Installing Flatpak Packages"
log_message "BLUE" "################################################################"

# Check if flatpak is installed
if ! command -v flatpak &> /dev/null; then
    log_message "RED" "flatpak is not installed. Please install it first to manage Flatpak packages."
    exit 1
fi

# Install packages
total=${#packages[@]}
current=0
failed_packages=()

for package in "${packages[@]}"; do
    ((current++))
    log_message "BLUE" "[${current}/${total}] Processing package: ${package}"
    if ! install_flatpak "$package"; then
        failed_packages+=("$package")
    fi
done

if [ ${#failed_packages[@]} -gt 0 ]; then
    log_message "RED" "The following Flatpak packages failed to install:"
    for fail in "${failed_packages[@]}"; do
        log_message "RED" "- $fail"
    done
fi

log_message "GREEN" "################################################################"
log_message "GREEN" "                    Flatpak Installation Complete!"
log_message "GREEN" "################################################################"