#!/bin/bash

# Color definitions
GREEN=$(tput setaf 2)
BLUE=$(tput setaf 4)
CYAN=$(tput setaf 6)
YELLOW=$(tput setaf 3)
RESET=$(tput sgr0)

# Check if root is using BTRFS
FILESYSTEM=$(df -T / | awk 'NR==2 {print $2}')

if [ "$FILESYSTEM" != "btrfs" ]; then
    echo "${YELLOW}################################################################"
    echo "              System not using BTRFS - Skipping setup"
    echo "################################################################${RESET}"
    exit 0
fi

echo "${BLUE}################################################################"
echo "                    Setting Up BTRFS Configuration"
echo "################################################################${RESET}"

# Create autostart directory
echo "${CYAN}Creating autostart directory...${RESET}"
mkdir -p "$HOME/.config/autostart"

# Copy BTRFS autostart configurations
echo "${CYAN}Copying BTRFS configurations...${RESET}"
cp -Rf ~/i3wm/personal-settings/autostart/* ~/.config/autostart/

echo "${GREEN}################################################################"
echo "                    BTRFS Setup Complete!"
echo "################################################################${RESET}"