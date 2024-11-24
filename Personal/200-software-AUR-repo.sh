#!/bin/bash

# This script installs a list of packages from the AUR on an Arch Linux system.

# Error handling
set -e
trap 'echo "An error occurred at line $LINENO. Exiting." >&2; exit 1' ERR

# Function to install a package if not already present
install_package() {
    if ! paru -Qqm "$1" &> /dev/null; then
        echo -e "\e[32mInstalling package: $1\e[0m"
        paru --noconfirm --needed "$1"
    else
        echo -e "\e[33mPackage $1 is already installed\e[0m"
    fi
}

# List of packages to install from AUR
packages=(
    baobab-git
    bluetooth-autoconnect
    brave-bin
    chrome-remote-desktop
    ttf-font-awesome-5
    github-desktop-bin
    gnome-disk-utility
    insync-thunar
    pamac-aur
    proton-vpn-gtk-app
    # Commented out packages can be uncommented if needed
    # grub-hook
)

# Update all packages before installing new ones
echo -e "\e[34mUpdating system and AUR packages\e[0m"
paru -Syu --noconfirm

# Install the packages
for package in "${packages[@]}"; do
    install_package "$package"
done

echo -e "\e[32mAll specified packages have been processed\e[0m"
