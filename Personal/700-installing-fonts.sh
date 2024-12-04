#!/bin/bash

# Author: Brett Crisp

# Color definitions
GREEN=$(tput setaf 2)
BLUE=$(tput setaf 4)
CYAN=$(tput setaf 6)
RESET=$(tput sgr0)

function install_package() {
    if ! paru -Qi "$1" &> /dev/null; then
        echo "${CYAN}Installing: $1${RESET}"
        paru --noconfirm --needed "$1"
    else
        echo "${GREEN}Already installed: $1${RESET}"
    fi
}

echo "${BLUE}################################################################"
echo "                    Installing Font Packages"
echo "################################################################${RESET}"

# Font packages
fonts=(
    adobe-source-sans-pro-fonts
    awesome-terminal-fonts
    cantarell-fonts
    ttf-bitstream-vera
    ttf-firacode-nerd
    ttf-font-awesome-6
    ttf-inconsolata
    ttf-liberation
    ttf-opensans
    ttf-vista-fonts
)

# Install fonts
total=${#fonts[@]}
current=0

for font in "${fonts[@]}"; do
    ((current++))
    echo "${BLUE}[${current}/${total}] Processing font: ${font}${RESET}"
    install_package "$font"
done

echo "${GREEN}################################################################"
echo "                    Font Installation Complete!"
echo "################################################################${RESET}"