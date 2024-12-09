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
        if ! sudo pacman -S --noconfirm --needed "$1"; then
            echo "${RED}Failed to install: $1${RESET}"
            return 1
        fi
    else
        echo "${GREEN}Already installed: $1${RESET}"
    fi
}

function package_exists() {
    pacman -Ss "^$1$" &> /dev/null
}

# Print header
echo "${BLUE}################################################################"
echo "                    Installing i3 Window Manager"
echo "################################################################${RESET}"

# Core i3 packages
declare -A i3_packages=(
# These packagesare only added to /etc/skel. I don't believe I need them.
#    "arcolinux-gtk3-sardi-arc-git"
#    "arcolinux-i3wm-git"
#    "arcolinux-nitrogen-git"
#    "arcolinux-polybar-git"
#    "arcolinux-powermenu-git"
#    "arcolinux-rofi-git"
#    "arcolinux-rofi-themes-git"
#    "arcolinux-volumeicon-git"

#    Doesn't look like I need i3status when I'm using Polybar. The only time would be if
#    installing i3 directly instead of installing after xfce install.
#    "i3status" 

    # Window Manager Core
    ["i3-wm"]="Core window manager"
    ["autotiling"]="Automatic tiling"
    
    # Appearance
    ["lxappearance"]="GTK theme switcher"
    ["feh"]="Wallpaper setter"
    ["picom"]="Compositor"
    
    # Utilities
    ["rofi"]="Application launcher"
    ["volumeicon"]="Volume control"
)

# Install packages
echo "${CYAN}Installing i3 packages...${RESET}"
total=${#i3_packages[@]}
current=0

# Installation with descriptions
for package in "${!i3_packages[@]}"; do
    ((current++))
    echo "${BLUE}[${current}/${total}] Processing: ${package} - ${i3_packages[$package]}${RESET}"
    install_package "$package"
done

echo "${GREEN}################################################################"
echo "                    i3 Installation Complete!"
echo "################################################################${RESET}"