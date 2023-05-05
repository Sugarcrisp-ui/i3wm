#!/bin/bash

# The set command is used to determine action if error
# is encountered.  (-e) will stop and exit (+e) will
# continue with the script.
set -e

###############################################################################
#
#   DECLARATION OF FUNCTIONS
#
###############################################################################

# Installs a package if it's not already installed
func_install() {
    local pkg="$1"
    if pacman -Qi "$pkg" &>/dev/null; then
        printf "\e[32m###############################################################################\n"
        printf "################## The package %s is already installed\n" "$pkg"
        printf "###############################################################################\n\n"
    else
        printf "\e[33m###############################################################################\n"
        printf "##################  Installing package %s\n" "$pkg"
        printf "###############################################################################\n\n"
        sudo pacman -S --noconfirm --needed "$pkg"
    fi
}

###############################################################################
#   MAIN
###############################################################################

# Install sound-related packages
printf "Installation of sound software\n"
printf "################################\n\n"
list=(
    pulseaudio
    pulseaudio-alsa
    pavucontrol
    alsa-firmware
    alsa-lib
    alsa-plugins
    alsa-utils
    gstreamer
    gst-plugins-good
    gst-plugins-bad
    gst-plugins-base
    gst-plugins-ugly
    playerctl
    volumeicon
)

count=0
for name in "${list[@]}"; do
    count=$((count+1))
    printf "\e[33mInstalling package nr. %s %s\n" "$count" "$name"
    func_install "$name"
done

printf "\e[36m################################################################\n"
printf "Software has been installed\n"
printf "################################################################\n\n"
