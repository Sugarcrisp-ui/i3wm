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

# Check for ArcoLinux repos
function check_repos() {
    log_message "CYAN" "Checking ArcoLinux repositories..."
    if grep -q arcolinux_repo /etc/pacman.conf; then
        log_message "GREEN" "ArcoLinux repos already present"
    else
        if [ ! -f "arch/get-the-keys-and-repos.sh" ]; then
            log_message "RED" "arch/get-the-keys-and-repos.sh not found."
            exit 1
        fi
        log_message "CYAN" "Getting ArchLinux keys and mirrors"
        sh arch/get-the-keys-and-repos.sh || { log_message "RED" "Failed to get keys and repos"; exit 1; }
        pacman -Sy || { log_message "RED" "Failed to sync pacman databases"; exit 1; }
    fi
}

# Install ArcoLinux/ArchLinux software
function install_software() {
    log_message "BLUE" "################################################################"
    log_message "BLUE" "                Installing ArcoLinux Software"
    log_message "BLUE" "################################################################"

    packages=(
        "appstream"
        "archlinux-logout-git"
        "archlinux-tweak-tool-git"
        "arcolinux-bin-git"
        "arcolinux-hblock-git"
    )

    total=${#packages[@]}
    current=0

    for package in "${packages[@]}"; do
        ((current++))
        log_message "CYAN" "[${current}/${total}] Installing: ${package}"
        if ! pacman -S --noconfirm --needed "$package" &>/dev/null; then
            log_message "RED" "Failed to install: $package"
        else
            log_message "GREEN" "Successfully installed: $package"
        fi
    done

    log_message "GREEN" "################################################################"
    log_message "GREEN" "            ArcoLinux Software Installation Complete!"
    log_message "GREEN" "################################################################"
}

# Run installation
check_repos
install_software