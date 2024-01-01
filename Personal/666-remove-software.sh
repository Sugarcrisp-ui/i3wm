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

# Function to remove a package
function_remove() {
  if pacman -Qi "$1" &> /dev/null; then
    tput setaf 1
    echo "################################################################"
    echo "######    "$1" is installed and will be removed now."
    echo "################################################################"
    echo
    tput sgr0
    sudo pacman -Rs "$1" --noconfirm
  else
    tput setaf 2
    echo "################################################################"
    echo "######    "$1" was not present or already removed."
    echo "################################################################"
    echo
    tput sgr0
  fi
}

# List of packages to uninstall
packages=(
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

# Uninstall packages
for package in "${packages[@]}"; do
  function_remove "$package"
done

echo -e "\e[32m################################################################"
echo "######                    packages uninstalled            ######"
echo "################################################################\e[0m"