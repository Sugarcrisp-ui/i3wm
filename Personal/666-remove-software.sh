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

# Function to check if an NVIDIA GPU is present
check_for_nvidia() {
  if lspci | grep -i nvidia &> /dev/null; then
    return 0 # NVIDIA GPU found
  else
    return 1 # No NVIDIA GPU found
  fi
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
packages_to_uninstall=(
  i3blocks
  termite
  vim
  xf86-video-amdgpu
  xf86-video-ati
  xf86-video-fbdev
  xf86-video-openchrome
  xf86-video-vesa
  conky
)

# Check for NVIDIA GPU and add xf86-video-nouveau to the uninstall list if not found
if ! check_for_nvidia; then
  packages_to_uninstall+=("xf86-video-nouveau")
  echo -e "\e[32mNo NVIDIA GPU detected. Adding xf86-video-nouveau to uninstall list.\e[0m"
else
  echo -e "\e[33mNVIDIA GPU detected. Skipping xf86-video-nouveau uninstallation.\e[0m"
fi

# Uninstall packages
for package in "${packages_to_uninstall[@]}"; do
  function_remove "$package"
done

echo -e "\e[32m################################################################"
echo "######                    packages uninstalled            ######"
echo "################################################################\e[0m"
