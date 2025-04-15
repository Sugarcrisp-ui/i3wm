#!/bin/bash

# Author: Brett Crisp
# Configures laptop-specific settings

# Color definitions
GREEN=$(tput setaf 2)
CYAN=$(tput setaf 6)
YELLOW=$(tput setaf 3)
RESET=$(tput sgr0)

echo "${CYAN}################################################################"
echo "                    Laptop Configuration"
echo "################################################################${RESET}"

if dmidecode -t system | grep -qi 'laptop\|notebook'; then
    echo "${CYAN}Detected laptop - installing TLP...${RESET}"
    pacman -Qi tlp &>/dev/null || sudo pacman -S --noconfirm tlp || {
        echo "${YELLOW}Failed to install TLP${RESET}"
        exit 1
    }
else
    echo "${YELLOW}Not a laptop - skipping TLP setup${RESET}"
fi

echo "${GREEN}################################################################"
echo "                    Laptop Configuration Complete!"
echo "################################################################${RESET}"
