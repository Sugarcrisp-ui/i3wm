#!/bin/bash

# Author: Brett Crisp
# Cleans up temporary files and caches

# Color definitions
GREEN=$(tput setaf 2)
CYAN=$(tput setaf 6)
RESET=$(tput sgr0)

echo "${CYAN}################################################################"
echo "                    Cleaning Up"
echo "################################################################${RESET}"

# Remove orphaned packages
pacman -Qtdq &>/dev/null && sudo pacman -Rns --noconfirm $(pacman -Qtdq)

# Clear package caches
sudo pacman -Sc --noconfirm
paru -Sc --noconfirm

# Remove linux-zen kernel
pacman -Qi linux-zen &>/dev/null && sudo pacman -Rns linux-zen linux-zen-headers --noconfirm
[ -f /boot/loader/entries/arch-zen.conf ] && sudo rm /boot/loader/entries/arch-zen.conf
sudo bootctl update
sudo mkinitcpio -P

# Remove temporary files
rm -rf "$HOME/Downloads/*.pkg.tar.zst"

# Remove conkyzen desktop entry
[ -f /usr/share/applications/conkyzen.desktop ] && sudo rm /usr/share/applications/conkyzen.desktop

echo "${GREEN}################################################################"
echo "                    Cleanup Complete!"
echo "################################################################${RESET}"
