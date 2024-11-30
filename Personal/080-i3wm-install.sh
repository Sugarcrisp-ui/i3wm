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
  pacman -Qi "$1" &> /dev/null
}

# Function to remove a package.
function remove_package() {
  if is_installed "$1"; then
    echo -e "\e[33mRemoving package: $1\e[0m"
    sudo pacman -R --noconfirm "$1"
  else
    echo -e "\e[34mPackage $1 is not installed. Skipping removal...\e[0m"
  fi
}

# Function to install a package.
function install_package() {
  if ! is_installed "$1"; then
    echo -e "\e[32mInstalling package: $1\e[0m"
    sudo pacman -S --noconfirm --needed "$1"
  else
    echo -e "\e[34mPackage $1 is already installed. Skipping...\e[0m"
  fi
}

# List of packages for the 'i3' category, preserving commented-out lines.
declare -a i3_packages=(
  # "alacritty"
  # "arcolinux-config-all-desktops-git"
  # "arcolinux-dconf-all-desktops-git"
  "arcolinux-gtk3-sardi-arc-git"
  "arcolinux-i3wm-git"
  # "arcolinux-local-xfce4-git"
  # "archlinux-logout-git"
  "arcolinux-nitrogen-git"
  "arcolinux-polybar-git"
  "arcolinux-powermenu-git"
  "arcolinux-rofi-git"
  "arcolinux-rofi-themes-git"
  # "arcolinux-root-git"
  "arcolinux-volumeicon-git"
  # "arcolinux-wallpapers-git"
 # This is the base install "arconet-xfce"
  "autotiling"
  # "dmenu"
  # "feh"
  # "gvfs"
  # "i3blocks"
  "i3-wm"
  "i3status"
  "lxappearance"
  "nitrogen"
  "picom"
  # "polkit-gnome"
  #"polybar"
  "rofi-lbonn-wayland"
  # "thunar"
  # "thunar-archive-plugin"
  # "thunar-volman"
  # "ttf-hack"
  "volumeicon"
  # "xfce4-terminal"
)

# Remove the conflicting package before installing
remove_package "arcolinux-gtk-surfn-arc-git"

# Function to install all uncommented packages in the array.
function install_category() {
  local category_name=$1
  declare -n category_packages=$2 # Use name reference for array
  echo -e "\e[32mInstalling packages for category: $category_name\e[0m"
  for package in "${category_packages[@]}"; do
    # Skip commented lines.
    if [[ $package == \#* ]]; then
      echo -e "\e[33mSkipping commented-out package: ${package#\# }\e[0m"
      continue
    fi
    install_package "$package"
  done
}

# Install all packages in the 'i3' category.
install_category "i3" i3_packages

# Success message.
echo -e "\e[32mAll uncommented software for i3 has been installed successfully.\e[0m"
