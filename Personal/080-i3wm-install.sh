#!/bin/bash

# Author: Brett Crisp

# Color definitions
GREEN=$(tput setaf 2)
BLUE=$(tput setaf 4)
CYAN=$(tput setaf 6)
RED=$(tput setaf 1)
RESET=$(tput sgr0)

function is_installed() {
    pacman -Qi "$1" &> /dev/null
}

function install_package() {
    if ! is_installed "$1"; then
        echo "${CYAN}Installing: $1${RESET}"
        sudo pacman -S --noconfirm --needed "$1"
    else
        echo "${GREEN}Already installed: $1${RESET}"
    fi
}

# Print header
echo "${BLUE}################################################################"
echo "                    Installing i3 Window Manager"
echo "################################################################${RESET}"

# Core i3 packages
declare -a i3_packages=(
#    "arcolinux-gtk3-sardi-arc-git"
#    "arcolinux-i3wm-git"
#    "arcolinux-nitrogen-git"
#    "arcolinux-polybar-git"
#    "arcolinux-powermenu-git"
#    "arcolinux-rofi-git"
#    "arcolinux-rofi-themes-git"
#    "arcolinux-volumeicon-git"
    "autotiling"
    "i3-wm"
    "i3status"
    "lxappearance"
    "nitrogen"
    "picom"
    "rofi-lbonn-wayland"
    "volumeicon"
)

# Remove conflicting package
#echo "${CYAN}Removing conflicting packages...${RESET}"
#sudo pacman -R --noconfirm arcolinux-gtk-surfn-arc-git 2>/dev/null || true

# Install packages
echo "${CYAN}Installing i3 packages...${RESET}"
total=${#i3_packages[@]}
current=0

for package in "${i3_packages[@]}"; do
    ((current++))
    echo "${BLUE}[${current}/${total}] Processing package: ${package}${RESET}"
    install_package "$package"
done

echo "${GREEN}################################################################"
echo "                    i3 Installation Complete!"
echo "################################################################${RESET}"