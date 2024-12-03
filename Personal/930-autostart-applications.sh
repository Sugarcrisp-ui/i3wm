#!/bin/bash

# Color definitions
GREEN=$(tput setaf 2)
BLUE=$(tput setaf 4)
CYAN=$(tput setaf 6)
RESET=$(tput sgr0)

echo "${BLUE}################################################################"
echo "                    Setting Up Autostart Applications"
echo "################################################################${RESET}"

# Create autostart directory if it doesn't exist
echo "${CYAN}Creating autostart directory...${RESET}"
mkdir -p "$HOME/.config/autostart"

# Copy autostart files
echo "${CYAN}Copying autostart configurations...${RESET}"
cp -Rf ~/i3wm/personal-settings/autostart/* ~/.config/autostart/

echo "${GREEN}################################################################"
echo "                    Autostart Applications Configured!"
echo "################################################################${RESET}"