#!/bin/bash

# Author: Brett Crisp

# Color definitions
GREEN=$(tput setaf 2)
BLUE=$(tput setaf 4)
CYAN=$(tput setaf 6)
RESET=$(tput sgr0)

# Flatpak packages
packages=(
    net.cozic.joplin_desktop
    com.github.unrud.VideoDownloader
    com.protonvpn.www
)

function install_flatpak() {
    if ! flatpak list | grep -q "$1"; then
        echo "${CYAN}Installing: $1${RESET}"
        flatpak install -y flathub "$1"
    else
        echo "${GREEN}Already installed: $1${RESET}"
    fi
}

echo "${BLUE}################################################################"
echo "                    Installing Flatpak Packages"
echo "################################################################${RESET}"

# Install packages
total=${#packages[@]}
current=0

for package in "${packages[@]}"; do
    ((current++))
    echo "${BLUE}[${current}/${total}] Processing package: ${package}${RESET}"
    install_flatpak "$package"
done

echo "${GREEN}################################################################"
echo "                    Flatpak Installation Complete!"
echo "################################################################${RESET}"