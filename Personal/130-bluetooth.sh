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
    if pacman -Qi "$1" &> /dev/null; then
        log_message "GREEN" "Already installed: $1"
    else
        log_message "CYAN" "Installing: $1"
        if ! pacman -S --noconfirm --needed "$1" &>/dev/null; then
            log_message "RED" "Failed to install: $1"
            return 1
        fi
    fi
    return 0
}

log_message "BLUE" "################################################################"
log_message "BLUE" "                    Setting Up Bluetooth"
log_message "BLUE" "################################################################"

# Bluetooth packages
packages=(
    "bluez"
    "bluez-libs"
    "bluez-utils"
    "blueman"
)

if ! pacman -Qi pipewire-pulse &> /dev/null; then 
    packages+=("pulseaudio-bluetooth")
fi

# Install packages
log_message "CYAN" "Installing bluetooth packages..."
for package in "${packages[@]}"; do
    install_package "$package"
done

# Setup Bluetooth services
log_message "CYAN" "Setting up Bluetooth services..."
sudo systemctl enable bluetooth.service || log_message "RED" "Failed to enable bluetooth service"
sudo systemctl start bluetooth.service || log_message "RED" "Failed to start bluetooth service"

# Configure Bluetooth
log_message "CYAN" "Configuring Bluetooth..."
if ! sudo sed -i 's/'#AutoEnable=false'/'AutoEnable=true'/g' /etc/bluetooth/main.conf; then
    log_message "RED" "Failed to configure /etc/bluetooth/main.conf"
fi

# Configure PulseAudio modules
if [ -w /etc/pulse/system.pa ]; then
    for module in "module-switch-on-connect" "module-bluetooth-policy" "module-bluetooth-discover"; do
        if ! grep -q "load-module $module" /etc/pulse/system.pa; then
            echo "load-module $module" | sudo tee --append /etc/pulse/system.pa > /dev/null
            log_message "CYAN" "Added $module to /etc/pulse/system.pa"
        else
            log_message "GREEN" "$module already in /etc/pulse/system.pa"
        fi
    done
else
    log_message "RED" "Cannot write to /etc/pulse/system.pa. Check permissions."
fi

log_message "GREEN" "################################################################"
log_message "GREEN" "                    Bluetooth Setup Complete!"
log_message "GREEN" "################################################################"