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

function install_package() {
    if ! paru -Qi "$1" &> /dev/null; then
        log_message "CYAN" "Installing: $1"
        if ! paru --noconfirm --needed "$1" &>/dev/null; then
            log_message "RED" "Failed to install: $1"
            return 1
        fi
    else
        log_message "GREEN" "Already installed: $1"
    fi
    return 0
}

log_message "BLUE" "################################################################"
log_message "BLUE" "                    Installing Font Packages"
log_message "BLUE" "################################################################"

# Check if paru is installed
if ! command -v paru &> /dev/null; then
    log_message "RED" "paru is not installed. Please install it to manage AUR packages."
    exit 1
fi

# Font packages
fonts=(
    adobe-source-sans-pro-fonts
    awesome-terminal-fonts
    cantarell-fonts
    ttf-bitstream-vera
    ttf-firacode-nerd
    ttf-font-awesome-6
    ttf-inconsolata
    ttf-liberation
    ttf-opensans
    ttf-vista-fonts
)

# Install fonts
total=${#fonts[@]}
current=0
failed_packages=()

for font in "${fonts[@]}"; do
    ((current++))
    log_message "BLUE" "[${current}/${total}] Processing font: ${font}"
    if ! install_package "$font"; then
        failed_packages+=("$font")
    fi
done

if [ ${#failed_packages[@]} -gt 0 ]; then
    log_message "RED" "The following font packages failed to install:"
    for fail in "${failed_packages[@]}"; do
        log_message "RED" "- $fail"
    done
else
    log_message "GREEN" "All font packages installed successfully."
fi

log_message "GREEN" "################################################################"
log_message "GREEN" "                    Font Installation Complete!"
log_message "GREEN" "################################################################"