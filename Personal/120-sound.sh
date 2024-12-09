#!/bin/bash

# Author: Brett Crisp

# Color definitions
GREEN=$(tput setaf 2)
BLUE=$(tput setaf 4)
CYAN=$(tput setaf 6)
YELLOW=$(tput setaf 3)
RED=$(tput setaf 1)
RESET=$(tput sgr0)

function install_package() {
    if pacman -Qi $1 &> /dev/null; then
        echo "${GREEN}Already installed: $1${RESET}"
    else
        echo "${CYAN}Installing: $1${RESET}"
        sudo pacman -S --noconfirm --needed $1
    fi
}

echo "${BLUE}################################################################"
echo "                    Setting Up Sound System"
echo "################################################################${RESET}"

# Sound packages
packages=(
    # Already installed pulseaudio-alsa
    # pavucontrol
    # alsa-firmware
    # Already installed alsa-lib
    # alsa-plugins
    # Already installed alsa-utils
    # gstreamer
    # gst-plugins-good
    # gst-plugins-bad
    # gst-plugins-base
    # gst-plugins-ugly
    pasystray
    # playerctl
    # Already installed volumeicon
)

# Install packages
echo "${CYAN}Installing sound packages...${RESET}"
for package in "${packages[@]}"; do
    [[ $package == \#* ]] && continue
    install_package "$package"
done

# Setup PulseAudio
echo "${CYAN}Setting up PulseAudio services...${RESET}"
systemctl --user enable pulseaudio.service
systemctl --user start pulseaudio.service

# Verify PulseAudio status
if systemctl --user is-active --quiet pulseaudio.service; then
    echo "${GREEN}PulseAudio is running${RESET}"
else
    echo "${RED}PulseAudio start failed - check logs${RESET}"
fi


echo "${GREEN}################################################################"
echo "                    Sound Setup Complete!"
echo "################################################################${RESET}"