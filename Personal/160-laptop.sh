#!/usr/bin/env bash

# Author: Brett Crisp

declare -A colors=(
    [GREEN]="$(tput setaf 2)"
    [BLUE]="$(tput setaf 4)"
    [CYAN]="$(tput setaf 6)"
    [YELLOW]="$(tput setaf 3)"
    [RED]="$(tput setaf 1)"
    [RESET]="$(tput sgr0)"
)

function log_message() {
    local COLOR=${1}
    shift
    local MSG="${*}"
    echo -e "${colors[$COLOR]}${MSG}${RESET}"
}

function install_package() {
    if ! pacman -Qs "$1" &> /dev/null; then
        log_message "CYAN" "Installing: $1"
        if ! pacman -S --noconfirm --needed "$1" &>/dev/null; then
            log_message "RED" "Failed to install: $1"
            return 1
        fi
    else
        log_message "GREEN" "Already installed: $1"
    fi
    return 0
}

function is_laptop() {
    if ! sudo -n true 2>/dev/null; then
        log_message "RED" "sudo privileges required to check laptop status"
        exit 1
    fi
    if ! command -v dmidecode &> /dev/null; then
        log_message "RED" "dmidecode is not installed. Please install it to check for laptop status."
        exit 1
    fi
    sudo dmidecode -t system | grep -qi 'laptop\|notebook'
}

log_message "BLUE" "################################################################"
log_message "BLUE" "                    Laptop Configuration"
log_message "BLUE" "################################################################"

# Install and configure laptop-specific software
if is_laptop; then
    log_message "CYAN" "Detected laptop system - proceeding with TLP setup"
    install_package "tlp"
    
    log_message "CYAN" "Enabling TLP service..."
    sudo systemctl enable tlp.service || log_message "RED" "Failed to enable TLP service"
    if systemctl is-enabled tlp.service &>/dev/null; then
        log_message "GREEN" "TLP service enabled successfully"
    else
        log_message "RED" "TLP service enable failed"
    fi
else
    log_message "YELLOW" "Not a laptop system - skipping TLP setup"
fi

log_message "GREEN" "################################################################"
log_message "GREEN" "                    Laptop Configuration Complete!"
log_message "GREEN" "################################################################"