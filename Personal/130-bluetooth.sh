#!/bin/bash

# Author: Brett Crisp

# Color definitions
GREEN=$(tput setaf 2)
BLUE=$(tput setaf 4)
CYAN=$(tput setaf 6)
YELLOW=$(tput setaf 3)
RED=$(tput setaf 1)
RESET=$(tput sgr0)

function install_package() {
    if pacman -Qi $1 &> /dev/null; then
        echo "${GREEN}Already installed: $1${RESET}"
    else
        echo "${CYAN}Installing: $1${RESET}"
        sudo pacman -S --noconfirm --needed $1
    fi
}

echo "${BLUE}################################################################"
echo "                    Setting Up Bluetooth"
echo "################################################################${RESET}"

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
echo "${CYAN}Installing bluetooth packages...${RESET}"
for package in "${packages[@]}"; do
    install_package "$package"
done

# Setup Bluetooth services
echo "${CYAN}Setting up Bluetooth services...${RESET}"
sudo systemctl enable bluetooth.service
sudo systemctl start bluetooth.service

# Configure Bluetooth
echo "${CYAN}Configuring Bluetooth...${RESET}"
sudo sed -i 's/'#AutoEnable=false'/'AutoEnable=true'/g' /etc/bluetooth/main.conf

# Configure PulseAudio modules
for module in "module-switch-on-connect" "module-bluetooth-policy" "module-bluetooth-discover"; do
    if ! grep -q "load-module $module" /etc/pulse/system.pa; then
        echo "load-module $module" | sudo tee --append /etc/pulse/system.pa
    fi
done

echo "${GREEN}################################################################"
echo "                    Bluetooth Setup Complete!"
echo "################################################################${RESET}"