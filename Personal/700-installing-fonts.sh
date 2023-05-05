#!/bin/bash

# The set command is used to determine action if error 
# is encountered. (-e) will stop and exit, (+e) will 
# continue with the script.
set -e

###############################################################################
# Author: Brett Crisp
# Description: This script installs a list of fonts from the Arch User 
# Repository (AUR).
###############################################################################

# Install a package, if not already installed
func_install() {
    if pacman -Qi "$1" &> /dev/null; then
        tput setaf 2
        printf "###############################################################################\n"
        printf "The package %s is already installed\n" "$1"
        printf "###############################################################################\n\n"
        tput sgr0
    else
        tput setaf 3
        printf "###############################################################################\n"
        printf "Installing package %s\n" "$1"
        printf "###############################################################################\n\n"
        tput sgr0
        sudo pacman -S --noconfirm --needed "$1" || { echo "Package installation failed"; exit 1; }
    fi
}

# Print a message to indicate which category of packages is being installed
func_category() {
    tput setaf 5
    printf "################################################################\n"
    printf "Installing software for category %s\n" "$1"
    printf "################################################################\n\n"
    tput sgr0
}

# Check if running as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
fi

###############################################################################
# List of packages to install
###############################################################################

pkg_list=(
arcolinux-fonts-git
awesome-terminal-fonts
adobe-source-sans-pro-fonts
ttf-bitstream-vera
ttf-droid
ttf-inconsolata
ttf-ubuntu-font-family
tamsyn-font
cantarell-fonts
noto-fonts
ttf-dejavu
ttf-droid
ttf-hack
ttf-liberation
ttf-roboto
)

###############################################################################
# Main script
###############################################################################

func_category "Fonts"

count=0
for pkg_name in "${pkg_list[@]}"; do
    ((count++))
    tput setaf 3
    printf "Installing package nr. %d %s\n" "$count" "$pkg_name"
    tput sgr0
    func_install "$pkg_name
