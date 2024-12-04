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
    if ! pacman -Qs "$1" &> /dev/null; then
        echo "${CYAN}Installing: $1${RESET}"
        sudo pacman -S --noconfirm --needed "$1"
    else
        echo "${GREEN}Already installed: $1${RESET}"
    fi
}

function is_laptop() {
    dmidecode -t system | grep -qi 'laptop\|notebook'
}

echo "${BLUE}################################################################"
echo "                    Laptop Configuration"
echo "################################################################${RESET}"

# Install and configure laptop-specific software
if is_laptop; then
    echo "${CYAN}Detected laptop system - proceeding with TLP setup${RESET}"
    install_package "tlp"
    
    echo "${CYAN}Enabling TLP service...${RESET}"
    sudo systemctl enable tlp.service
    
    if systemctl is-enabled tlp.service &>/dev/null; then
        echo "${GREEN}TLP service enabled successfully${RESET}"
    else
        echo "${RED}TLP service enable failed${RESET}"
    fi
else
    echo "${YELLOW}Not a laptop system - skipping TLP setup${RESET}"
fi

echo "${GREEN}################################################################"
echo "                    Laptop Configuration Complete!"
echo "################################################################${RESET}"