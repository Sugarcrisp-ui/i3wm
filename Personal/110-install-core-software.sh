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

# Function to install a package.
function install_package() {
  if ! is_installed "$1"; then
    echo -e "\e[32mInstalling package $1\e[0m"
    sudo pacman -S --noconfirm --needed "$1"
  fi
}

# Function to install a category of packages.
function install_category() {
  echo -e "\e[32mInstalling software for category $1\e[0m"
  for package in "${list[$1]}"; do
    install_package "$package"
  done
}

# List of packages to install.
list=(
#  "Web Browsers"=
    #chromium

#  "Multimedia"=
    ffmpeg
    losslesscut-bin
    #openshot
    simplescreenrecorder
    spotify

#  "Utilities"=
    bitwarden
    copyq
    flatpak
#    font-manager-git
    gnome-calculator
    gnome-disk-utility
    gufw
    gpick
    imagemagick
    insync
    inxi
    meld
    most
    pamac-aur
    paprefs
    pinta
    polybar
    potrace
    powerline
    qbittorrent
    qt5-graphicaleffects
    qt5-svg
    qt6ct
    realvnc-vnc-server
    realvnc-vnc-viewer
    rofi
    seahorse
    sshfs
    stow
    timeshift
#    timeshift-autosnap #only with btrfs
    unzip
    webapp-manager
    wget
    xclip
    xfce4-appfinder
    xfce4-notifyd
    xfce4-power-manager
    xfce4-screenshooter
    xfce4-settings
    xfce4-taskmanager
    xfce4-terminal
    zip

#  "Documents and Text"=
    geany
    libreoffice-still
    micro
    sublime-text-4

#  "Communication"=
#    arcolinux-teamviewer
#    discord

#  "Others"=
#    grub-btrfs
    upd72020x-fw
    arcolinux-sddm-sugar-candy-git
    
#  "Developer"=
#    virtualbox
)

# Install all of the packages.
for category in "${!list[@]}"; do
  install_category "$category"
done

# Success message.
echo -e "\e[32mSoftware has been installed\e[0m"
