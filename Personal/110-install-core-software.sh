#!/bin/bash

# Author: Brett Crisp

# This script installs a list of packages on an Arch Linux system.

# Set the error action to exit.
set -e

# Function to check if a package is installed.
function is_installed() {
  pacman -Qi "$1" &> /dev/null
}

# Function to install a package.
function install_package() {
  if ! is_installed "$1"; then
    echo "Installing package $1"
    sudo pacman -S --noconfirm --needed "$1"
  fi
}

# Function to install a category of packages.
function install_category() {
  echo "Installing software for category $1"
  for package in "${list[$1]}"; do
    install_package "$package"
  done
}

# List of packages to install.
list=(
#  "Web Browsers"=
    chromium
    google-chrome     

#  "Multimedia"=
    celluloid
    ffmpeg
    losslesscut-bin
    openshot
    simplescreenrecorder
    spotify
    vlc

#  "Utilities"=
    bitwarden
    catfish
    clipgrab
    copyq
    etcher-bin
    font-manager-git
    gnome-calculator
    gnome-disk-utility
    gpick
    insync
    inxi
    meld
    most
    nodejs-nativefier
    qbittorrent
    qt5-graphicaleffects
    qt5-quickcontrols2
    qt5-svg
    qt6ct
    realvnc-vnc-server
    realvnc-vnc-viewer
    rofi
    seahorse
    sshfs
    timeshift
    timeshift-autosnap
    unzip
    webapp-manager
    wget
    xfce4-appfinder
    xfce4-notifyd
    xfce4-power-manager
    xfce4-screenshooter
    xfce4-settings
    xfce4-taskmanager
    xfce4-terminal
    zip

#  "Documents and Text"=
    libreoffice-still
    micro
    sublime-text-4
    xournalpp
    xreader

#  "Communication"=
    arcolinux-teamviewer
#    discord
    signal-desktop

#  "Others"=
    aic94xx-firmware
    flatpak
#    grub-btrfs
    pamac
    paprefs
    paru-bin
    polybar
    powerline
    ttf-font-awesome
    upd72020x-fw
    wd719x-firmware

#  "Developer"=
    virtualbox
)

# Install all of the packages.
for category in "${!list[@]}"; do
  install_category "$category"
done

# Success message.
echo "Software has been installed"
