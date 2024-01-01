#!/bin/bash

# List of Flatpak packages to install
list=(
  net.nokyan.Resources
  com.github.PintaProject.Pinta
  org.freedesktop.Platform
  org.freedesktop.Platform
  org.freedesktop.Platform.GL.default
  org.freedesktop.Platform.GL.default
  org.freedesktop.Platform.GL.default
  org.freedesktop.Platform.GL.default
  org.freedesktop.Platform.VAAPI.Intel
  org.freedesktop.Platform.VAAPI.Intel
  org.freedesktop.Platform.ffmpeg-full
  org.freedesktop.Platform.openh264
  org.freedesktop.Sdk
  org.gnome.Platform
  org.gnome.Platform
  org.kde.Platform
  org.kde.Platform.
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