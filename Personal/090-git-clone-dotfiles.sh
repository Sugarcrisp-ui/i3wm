#!/bin/bash

# Author: Brett Crisp

# Color definitions
GREEN=$(tput setaf 2)
BLUE=$(tput setaf 4)
CYAN=$(tput setaf 6)
RESET=$(tput sgr0)

echo "${BLUE}################################################################"
echo "                    Setting Up Dotfiles"
echo "################################################################${RESET}"

# Clone or update dotfiles repository
if [ ! -d "$HOME/dotfiles" ]; then
    echo "${CYAN}Cloning dotfiles repository...${RESET}"
    git clone https://github.com/Sugarcrisp-ui/dotfiles.git ~/dotfiles
else
    echo "${CYAN}Updating existing dotfiles...${RESET}"
    cd ~/dotfiles && git pull origin main
fi

echo "${GREEN}################################################################"
echo "                    Dotfiles Setup Complete!"
echo "################################################################${RESET}"