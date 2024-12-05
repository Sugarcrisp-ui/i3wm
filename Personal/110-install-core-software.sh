#!/bin/bash

# Author: Brett Crisp

# Color definitions
GREEN=$(tput setaf 2)
BLUE=$(tput setaf 4)
CYAN=$(tput setaf 6)
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
echo "                Installing Core Software Packages"
echo "################################################################${RESET}"

# Core software packages
packages=(
    # arcolinux-teamviewer
    bitwarden
    blueman
    baobab
    brave-bin
    # grub-btrfs
    copyq
    cronie
    fd
    ffmpeg
    flatpak
    geany
    github-desktop-bin
    gnome-calculator
    gpick
    gufw
    insync
    libreoffice-still
    meld
    micro
    pamac-aur
    paprefs
    pinta
    polybar
    potrace
    powerline
    qbittorrent
    qt5-graphicaleffects
    qt5-svg
    qt6ct
    realvnc-vnc-server
    realvnc-vnc-viewer
    ripgrep
    seahorse
    # simplescreenrecorder
    spotify
    sshfs
    stow
    timeshift
    # Used with btrfs timeshift-autosnap
    virtualbox
    visual-studio-code-bin
    webapp-manager
    xclip
    zip
)

# Install packages
echo "${CYAN}Installing core software...${RESET}"
total=${#packages[@]}
current=0

for package in "${packages[@]}"; do
    [[ $package == \#* ]] && continue
    ((current++))
    echo "${BLUE}[${current}/${total}] Processing package: ${package}${RESET}"
    install_package "$package"
done

echo "${GREEN}################################################################"
echo "                Core Software Installation Complete!"
echo "################################################################${RESET}"