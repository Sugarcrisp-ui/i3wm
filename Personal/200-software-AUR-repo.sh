#!/bin/bash

# Author: Brett Crisp

# Color definitions
GREEN='\033[0;32m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
RESET='\033[0m'

# Function to check if package is installed
is_package_installed() {
    pacman -Q "$1" &> /dev/null
}

# Function to install a package using paru (handles both official and AUR packages)
install_package() {
    if ! is_package_installed "$1"; then
        echo "${CYAN}Installing: $1${RESET}"
        sudo paru -S --noconfirm --needed "$1" || {
            echo "${RED}Failed to install $1${RESET}"
            return 1
        }
    else
        echo "${GREEN}Already installed: $1${RESET}"
    fi
}

echo "${BLUE}################################################################"
echo "                    Installing Software Packages"
echo "################################################################${RESET}"

# Update system
echo "${CYAN}Updating system packages...${RESET}"
sudo paru -Syu --noconfirm

# Package lists
packages=(
    pamac-all
    ttf-font-awesome-5
    insync-thunar
)

# Install all packages
echo "${CYAN}Installing packages...${RESET}"
for package in "${packages[@]}"; do
    [[ $package == \#* ]] && continue  # skip commented packages
    install_package "$package"
done

echo "${GREEN}################################################################"
echo "                    Software Installation Complete!"
echo "################################################################${RESET}"