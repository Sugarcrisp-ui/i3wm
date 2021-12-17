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


#function_remove evolution
#function_remove orage
#function_remove malcontent
#function_remove guvcview
#function_remove inkscape
#function_remove pragha
#function_remove midori
#function_remove vlc
function_remove termite
#function_remove synapse
#function_remove gpick
#function_remove plank
#function_remove nomacs
#function_remove screenkey
#function_remove temps
#function_remove wttr
#function_remove caja
#function_remove pulseaudio-equalizer-ladspa
function_remove vim
#function_remove totem
#function_remove udisks2
#function_remove arcolinux-meta-fun
#function_remove vivaldi-ffmpeg-codecs
#function_remove vivaldi-widevine
#function_remove vivaldi
#function_remove brave
#function_remove xfce4-evince
#function_remove nemo
function_remove xf86-video-amdgpu
function_remove xf86-video-ati
function_remove xf86-video-fbdev
function_remove xf86-video-nouveau
function_remove xf86-video-openchrome
function_remove xf86-video-vesa

echo "################################################################"
echo "######                    packages uninstalled            ######"
echo "################################################################"
