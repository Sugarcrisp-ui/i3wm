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
#    This is only arco config added to skel "arcolinux-gtk3-sardi-arc-git"
#    This is only arco config added to skel "arcolinux-i3wm-git"
#    This is only arco config added to skel "arcolinux-nitrogen-git"
#    This is only arco config added to skel "arcolinux-polybar-git"
#    This is only arco config added to skel "arcolinux-powermenu-git"
#    This is only arco config added to skel "arcolinux-rofi-git"
#    This is only arco config added to skel "arcolinux-rofi-themes-git"
#    This is only arco config added to skel "arcolinux-volumeicon-git"
    "autotiling"
    "i3-wm"
    "i3status"
    "lxappearance"
    "nitrogen"
    "picom"
    "rofi-lbonn-wayland"
    "volumeicon"
)

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