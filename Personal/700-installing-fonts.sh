#!/bin/bash

# The set command is used to determine action if error 
# is encountered. (-e) will stop and exit, (+e) will 
# continue with the script.
set -e
trap 'handle_error' ERR

# Function to handle errors
handle_error() {
  echo -e "\e[31mAn error occurred while installing the packages. Please check the output and try again.\e[0m"
  exit 1
}

# Function to install a package.
function install_package() {
  if ! paru -Qi "$1" &> /dev/null; then
    echo -e "\e[32m###############################################################################\e[0m"
    echo -e "\e[32m##################  Installing package "  "$1"
    echo -e "\e[32m###############################################################################\e[0m"
    echo
    paru --noconfirm --needed "$1"
  fi
}

# Function to install a category of packages.
function install_category() {
  echo -e "\e[32m################################################################\e[0m"
  echo -e "Installing fonts " $1
  echo -e "\e[32m################################################################\e[0m"
  echo;tput sgr0
  
  for package in "${list[@]}"; do
    install_package "$package"
  done
}

# List of packages to install.
list=(
arcolinux-fonts-git
adobe-source-sans-pro-fonts
awesome-terminal-fonts
cantarell-fonts
noto-fonts
ttf-bitstream-vera
ttf-dejavu
ttf-droid
ttf-font-awesome
ttf-font-awesome-5
ttf-font-awesome-6
ttf-hack
ttf-inconsolata
ttf-liberation
ttf-ms-fonts
ttf-opensans
ttf-roboto
ttf-roboto-mono
ttf-ubuntu-font-family
ttf-vista-fonts
)

# Install all of the packages.
install_category "Fonts"

# Success message.
echo -e "\e[32m################################################################\e[0m"
echo -e "Software has been installed"
echo -e "\e[32m################################################################\e[0m"
echo;tput sgr0
