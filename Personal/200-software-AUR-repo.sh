#!/bin/bash

# Author: Brett Crisp

# This script installs a list of packages on an Arch Linux system.

# Function to handle errors
handle_error() {
  echo -e "\e[31mAn error occurred while installing the packages. Please check the output and try again.\e[0m"
  exit 1
}

# Set up error handling
trap 'handle_error' ERR

# Function to check if a package is installed.
function is_installed() {
  paru -Qqm "$1" &> /dev/null
}

# Function to install a package.
function install_package() {
  if ! is_installed "$1"; then
    echo -e "\e[32mInstalling package $1\e[0m"
    paru --noconfirm --needed "$1"
  fi
}

# Function to install a category of packages.
function install_category() {
  echo -e "\e[32mInstalling software for category $1\e[0m"
  for package in "${list[@]}"; do
    install_package "$package"
  done
}

# List of packages to install.
list=(
authy
baobab-git
bluetooth-autoconnect
chrome-remote-desktop
#converter
cryptomator-bin
expressvpn
github-desktop-bin
gnome-disk-utility
grub-hook
insync-thunar
joplin-appimage
pamac-aur
#rtl8821au-dkms-git
sublime-merge
#ttf-vista-fonts
ttf-font-awesome-5
)

# Install all of the packages.
install_category "Core Software"

# Success message.
echo -e "\e[32mSoftware has been installed\e[0m"