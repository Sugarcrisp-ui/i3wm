#!/bin/bash

# Author: Brett Crisp
# Installs archlinux-logout

# Color definitions
GREEN=$(tput setaf 2)
CYAN=$(tput setaf 6)
RED=$(tput setaf 1)
RESET=$(tput sgr0)

echo "${CYAN}################################################################"
echo "                    Installing archlinux-logout"
echo "################################################################${RESET}"

mkdir -p ~/repos
cd ~/repos || {
    echo "${RED}Failed to change to repos directory${RESET}"
    exit 1
}

if [ ! -d archlinux-logout ]; then
    git clone https://github.com/Sugarcrisp-ui/archlinux-logout.git || {
        echo "${RED}Failed to clone archlinux-logout${RESET}"
        exit 1
    }
fi

cd archlinux-logout || {
    echo "${RED}Failed to change to archlinux-logout directory${RESET}"
    exit 1
}

makepkg -Csi --noconfirm || {
    echo "${RED}Failed to build archlinux-logout${RESET}"
    exit 1
}

echo "${GREEN}################################################################"
echo "                    archlinux-logout Installation Complete!"
echo "################################################################${RESET}"
