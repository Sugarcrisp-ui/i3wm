#!/bin/bash

# The set command is used to determine action if error
# is encountered.  (-e) will stop and exit (+e) will
# continue with the script.
set +e
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

function_remove termite
#function_remove vim
function_remove xf86-video-amdgpu
function_remove xf86-video-ati
function_remove xf86-video-fbdev
function_remove xf86-video-nouveau
function_remove xf86-video-openchrome
function_remove xf86-video-vesa

echo "################################################################"
echo "######                    packages uninstalled            ######"
echo "################################################################"
