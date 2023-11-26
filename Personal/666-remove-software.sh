#!/bin/bash

# The set command is used to determine action if error
# is encountered.  (-e) will stop and exit (+e) will
# continue with the script.
set -e
##################################################################################################################

function_remove() {
	if pacman -Qi $1 &> /dev/null; then
		tput setaf 1
		echo "################################################################"
		echo "######    "$1" is installed and will be removed now."
		echo "################################################################"
		echo
		tput sgr0
		sudo pacman -Rs $1 --noconfirm
	else
		tput setaf 2
		echo "################################################################"
		echo "######    "$1" was not present or already removed."
		echo "################################################################"
		echo
		tput sgr0
	fi
}

PACKAGES=(
	i3blocks
    termite
    vim
    xf86-video-amdgpu
    xf86-video-ati
    xf86-video-fbdev
    xf86-video-nouveau
    xf86-video-openchrome
    xf86-video-vesa
)

for PACKAGE in "${PACKAGES[@]}"; do
    function_remove "$PACKAGE"
    
done

echo "################################################################"
echo "######                    packages uninstalled            ######"
echo "################################################################"
