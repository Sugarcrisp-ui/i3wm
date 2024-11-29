#!/bin/bash

# Function to install a package if it's not already installed
func_install() {
  if pacman -Qi $1 &> /dev/null; then
    tput setaf 2
    echo "###############################################################################"
    echo "################## The package "$1" is already installed"
    echo "###############################################################################"
    echo
    tput sgr0
  else
    tput setaf 3
    echo "###############################################################################"
    echo "##################  Installing package "  $1
    echo "###############################################################################"
    echo
    tput sgr0
    sudo pacman -S --noconfirm --needed $1 
  fi
}

# List of PulseAudio related packages to ensure are installed
packages=(
# Already installed  pulseaudio-alsa
  pavucontrol
  alsa-firmware
# Already installed  alsa-lib
  alsa-plugins
# Already installed  alsa-utils
  gstreamer
  gst-plugins-good
  gst-plugins-bad
  gst-plugins-base
  gst-plugins-ugly
  pasystray
  playerctl
# Already installed  volumeicon
)

# Install the packages
for package in "${packages[@]}"; do
  func_install "$package"
done

# Enable and start PulseAudio for the current user
systemctl --user enable pulseaudio.service
systemctl --user start pulseaudio.service

# Check if PulseAudio started successfully
if systemctl --user is-active --quiet pulseaudio.service; then
  echo "PulseAudio is now enabled and running."
else
  echo "Warning: PulseAudio did not start. Check system logs for details."
fi

tput setaf 11;
echo "################################################################"
echo "PulseAudio setup has been completed"
echo "################################################################"
echo
tput sgr0
