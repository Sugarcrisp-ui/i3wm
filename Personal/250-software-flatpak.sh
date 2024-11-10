#!/bin/bash

# List of Flatpak packages to install
list=(
  net.cozic.joplin_desktop
  com.github.unrud.VideoDownloader
)

# Function to check if a Flatpak is installed
function is_installed() {
  flatpak list | grep -q "$1"
}

# Function to install a Flatpak
function install_flatpak() {
  if ! is_installed "$1"; then
    flatpak install -y flathub "$1"
  fi
}

# Check for installed Flatpaks and install any missing ones
for package in "${list[@]}"; do
  install_flatpak "$package"
done
