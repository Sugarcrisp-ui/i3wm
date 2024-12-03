#!/bin/bash

# Color definitions
GREEN=$(tput setaf 2)
BLUE=$(tput setaf 4)
CYAN=$(tput setaf 6)
RESET=$(tput sgr0)

# Check for ArcoLinux repos
function check_repos() {
    echo "${CYAN}Checking ArcoLinux repositories...${RESET}"
    if grep -q arcolinux_repo /etc/pacman.conf; then
        echo "${GREEN}ArcoLinux repos already present${RESET}"
    else
        echo "${CYAN}Getting ArchLinux keys and mirrors${RESET}"
        sh arch/get-the-keys-and-repos.sh
        sudo pacman -Sy
    fi
}

# Install ArcoLinux/ArchLinux software
function install_software() {
    echo "${BLUE}################################################################"
    echo "                Installing ArcoLinux Software"
    echo "################################################################${RESET}"

    packages=(
        "appstream"
        "archlinux-logout-git"
        "archlinux-tweak-tool-git"
        "arcolinux-bin-git"
        "arcolinux-hblock-git"
        "arcolinux-wallpapers-git"
    )

    total=${#packages[@]}
    current=0

    for package in "${packages[@]}"; do
        ((current++))
        echo "${CYAN}[${current}/${total}] Installing: ${package}${RESET}"
        sudo pacman -S --noconfirm --needed "$package"
    done

    echo "${GREEN}################################################################"
    echo "            ArcoLinux Software Installation Complete!"
    echo "################################################################${RESET}"
}

# Run installation
check_repos
install_software