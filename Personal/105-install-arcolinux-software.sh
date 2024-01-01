#!/bin/bash

# The set command is used to determine action if error
# is encountered.  (-e) will stop and exit (+e) will
# continue with the script.
set -e
trap 'handle_error' ERR

# Function to handle errors
handle_error() {
  echo -e "\e[31mAn error occurred while installing the ArcoLinux software. Please check the output and try again.\e[0m"
  exit 1
}

# Function to check if ArcoLinux repos are in /etc/pacman.conf
function check_repos() {
  if grep -q arcolinux_repo /etc/pacman.conf; then
    echo
    tput setaf 2
    echo "################################################################"
    echo "################ ArcoLinux repos are already in /etc/pacman.conf"
    echo "################################################################"
    tput sgr0
    echo
  else
    echo
    tput setaf 2
    echo "################################################################"
    echo "################ Getting the keys and mirrors for ArchLinux"
    echo "################################################################"
    tput sgr0
    echo
    sh arch/get-the-keys-and-repos.sh
    sudo pacman -Sy
  fi
}

# Function to install ArcoLinux software
function install_software() {
  sudo pacman -S --noconfirm --needed appstream
  sudo pacman -S --noconfirm --needed arcolinux-bin-git
  sudo pacman -S --noconfirm --needed arcolinux-hblock-git
  sudo pacman -S --noconfirm --needed arcolinux-pamac-aur
  sudo pacman -S --noconfirm --needed arcolinux-wallpapers-git
  sudo pacman -S --noconfirm --needed archlinux-logout-git
  sudo pacman -S --noconfirm --needed archlinux-tweak-tool-git

  echo
  tput setaf 2
  echo "################################################################"
  echo "################ ArcoLinux software installed"
  echo "################################################################"
  tput sgr0
  echo
}

# Check for ArcoLinux repos and install the software
check_repos
install_software