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
    echo -e "${colors[$COLOR]}${MSG}${RESET}"
}

function check_for_nvidia() {
    if ! lspci | grep -i nvidia &> /dev/null; then
        log_message "CYAN" "No NVIDIA GPU detected"
        return 1
    else
        log_message "YELLOW" "NVIDIA GPU detected"
        return 0
    fi
}

function remove_package() {
    if pacman -Qi "$1" &> /dev/null; then
        log_message "CYAN" "Removing: $1"
        if ! sudo pacman -Rs "$1" --noconfirm &>/dev/null; then
            log_message "RED" "Failed to remove: $1"
            return 1
        fi
    else
        log_message "YELLOW" "Not installed: $1"
    fi
    return 0
}

log_message "BLUE" "################################################################"
log_message "BLUE" "                    Removing Unnecessary Software"
log_message "BLUE" "################################################################"

# Packages to remove
packages_to_uninstall=(
    arcolinux-conky-collection-git
    blueberry
    conky-lua-archers
)

log_message "BLUE" "Removing ConkyZen Desktop Entry"
if ! sudo rm -f /usr/share/applications/conkyzen.desktop; then
    log_message "RED" "Failed to remove conkyzen.desktop"
fi

# Add nouveau if no NVIDIA GPU
if ! check_for_nvidia; then
    packages_to_uninstall+=("xf86-video-nouveau")
fi

# Remove packages
total=${#packages_to_uninstall[@]}
current=0
failed_packages=()

for package in "${packages_to_uninstall[@]}"; do
    ((current++))
    log_message "BLUE" "[${current}/${total}] Processing package: ${package}"
    if ! remove_package "$package"; then
        failed_packages+=("$package")
    fi
done

if [ ${#failed_packages[@]} -gt 0 ]; then
    log_message "RED" "The following packages failed to be removed:"
    for fail in "${failed_packages[@]}"; do
        log_message "RED" "- $fail"
    done
else
    log_message "GREEN" "All specified packages removed successfully."
fi

log_message "GREEN" "################################################################"
log_message "GREEN" "                    Software Removal Complete!"
log_message "GREEN" "################################################################"