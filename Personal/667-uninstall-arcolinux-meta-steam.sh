#!/bin/bash

# The set command is used to determine action if error 
# is encountered.  (-e) will stop and exit (+e) will 
# continue with the script.
set -e
trap 'handle_error' ERR

# Function to handle errors
handle_error() {
  echo -e "\e[31mAn error occurred while uninstalling the packages. Please check the output and try again.\e[0m"
  exit 1
}

sudo pacman -Rs arcolinux-meta-steam steam lib32-libvdpau lib32-libva lib32-nvidia-utils lib32-libxtst lib32-libxrandr lib32-libpulse lib32-gdk-pixbuf2 \
lib32-gtk2 lib32-openal lib32-mesa lib32-gcc-libs lib32-libx11 lib32-libxss lib32-alsa-plugins lsof lib32-libgpg-error \
lib32-libindicator-gtk2 lib32-libdbusmenu-glib lib32-libdbusmenu-gtk2 lib32-nss

echo -e "\e[32m################################################################"
echo "####                      packages uninstalled            ######"
echo "################################################################\e[0m"