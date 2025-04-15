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
    echo "${CYAN}Enabling tlp.service...${RESET}"
    if systemctl list-unit-files | grep -q "tlp.service"; then
        sudo systemctl enable tlp.service || echo "${RED}Failed to enable tlp.service${RESET}"
        sudo systemctl start tlp.service || echo "${RED}Failed to start tlp.service${RESET}"
    else
        echo "${YELLOW}tlp.service not found${RESET}"
    fi
else
    echo "${YELLOW}Not a laptop - skipping TLP setup${RESET}"
fi

echo "${GREEN}################################################################"
echo "                    Laptop Configuration Complete!"
echo "################################################################${RESET}"
