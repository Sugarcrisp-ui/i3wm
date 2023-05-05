#!/bin/bash
# The set command is used to determine action if error
# is encountered.  (-e) will stop and exit (+e) will
# continue with the script.
set -e
###############################################################################
# Author  : Brett Crisp
###############################################################################

installed_dir=$(dirname $(readlink -f $(basename `pwd`)))

echo
tput setaf 2
echo "################################################################"
echo "################### ArcoLinux Software to install"
echo "################################################################"
tput sgr0
echo

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
  echo "################### Getting the keys and mirrors for ArcoLinux"
  echo "################################################################"
  tput sgr0
  echo
  sh arch/get-the-keys-and-repos.sh
  sudo pacman -Sy
fi

# Declare an array of packages to install
declare -a packages=(
"appstream" 
"arcolinux-bin-git" 
"arcolinux-hblock-git" 
"arcolinux-logout-git" 
"arcolinux-pamac-all" 
"archlinux-tweak-tool-git" 
"arcolinux-wallpapers-git"
)

# Define function to install packages
function install_package {
  if pacman -Qi $1 &> /dev/null; then
    echo "$1 is already installed"
  else
    echo "Installing $1..."
    sudo pacman -S --noconfirm --needed $1
  fi
}

# Install each package in the array
for package in "${packages[@]}"; do
  install_package "$package"
done

echo
tput setaf 2
echo "################################################################"
echo "################### Done"
echo "################################################################"
tput sgr0
echo
