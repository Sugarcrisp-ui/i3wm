#!/bin/bash

# Author: Brett Crisp

# Color definitions
GREEN=$(tput setaf 2)
BLUE=$(tput setaf 4)
CYAN=$(tput setaf 6)
YELLOW=$(tput setaf 3)
RESET=$(tput sgr0)

function check_for_nvidia() {
    lspci | grep -i nvidia &> /dev/null
}

function remove_package() {
    if pacman -Qi "$1" &> /dev/null; then
        echo "${CYAN}Removing: $1${RESET}"
        sudo pacman -Rs "$1" --noconfirm
    else
        echo "${YELLOW}Not installed: $1${RESET}"
    fi
}

echo "${BLUE}################################################################"
echo "                    Removing Unnecessary Software"
echo "################################################################${RESET}"

# Packages to remove
packages_to_uninstall=(
    arcolinux-conky-collection-git
    blueberry
    conky-lua-archers
)

log_message "Removing ConkyZen Desktop Entry"
sudo rm -f /usr/share/applications/conkyzen.desktop

# Add nouveau if no NVIDIA GPU
if ! check_for_nvidia; then
    packages_to_uninstall+=("xf86-video-nouveau")
    echo "${CYAN}No NVIDIA GPU - will remove nouveau driver${RESET}"
else
    echo "${YELLOW}NVIDIA GPU detected - keeping nouveau driver${RESET}"
fi

# Remove packages
total=${#packages_to_uninstall[@]}
current=0

for package in "${packages_to_uninstall[@]}"; do
    ((current++))
    echo "${BLUE}[${current}/${total}] Processing package: ${package}${RESET}"
    remove_package "$package"
done

echo "${GREEN}################################################################"
echo "                    Software Removal Complete!"
echo "################################################################${RESET}"