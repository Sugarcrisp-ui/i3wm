#!/bin/bash

# Author: Brett Crisp

# This script downloads and installs the Warp Terminal on an Arch Linux system.

# Function to handle errors
handle_error() {
  echo -e "\e[31mAn error occurred while installing Warp Terminal. Please check the output and try again.\e[0m"
  exit 1
}

# Set up error handling
trap 'handle_error' ERR

# Function to check if a package is installed.
function is_installed() {
  pacman -Qi "$1" &> /dev/null
}

# Function to download a package.
function download_package() {
  local download_url="$1"
  local package_name="$2"
  local download_dir="$3"

  echo -e "\e[32mDownloading $package_name\e[0m"
  if ! curl -L -o "$download_dir/$package_name" "$download_url"; then
    echo -e "\e[31mFailed to download $package_name\e[0m"
    handle_error
  fi
}

# Function to install a package from a local file.
function install_local_package() {
  local package_file="$1"

  if [ -f "$package_file" ]; then
    echo -e "\e[32mInstalling package from $package_file\e[0m"
    sudo pacman -U --noconfirm "$package_file"
  else
    echo -e "\e[31mFile $package_file does not exist\e[0m"
    handle_error
  fi
}

# Function to add repository if not present.
function add_repository() {
  local repo_name="$1"
  local repo_url="$2"

  if ! grep -q "$repo_name" /etc/pacman.conf; then
    echo -e "\e[32mAdding $repo_name repository to pacman.conf\e[0m"
    sudo sh -c "echo -e '\n[$repo_name]\nServer = $repo_url' >> /etc/pacman.conf"
    sudo pacman -Sy
  fi
}

# Function to manage the GPG key
function manage_gpg_key() {
  echo -e "\e[32mAdding and signing the GPG key for Warp\e[0m"
  curl -fsSL https://releases.warp.dev/linux/keys/warpdotdev.asc | gpg --dearmor -o /usr/share/keyrings/warpdotdev.asc
  echo -e "\e[32mSigning the GPG key\e[0m"
  gpg --import /usr/share/keyrings/warpdotdev.asc
  gpg --export --armor > /usr/share/keyrings/warpdotdev.asc
}

# Define paths and URLs
DOWNLOAD_DIR="$HOME/Downloads"
DOWNLOAD_URL="https://app.warp.dev/download?package=pacman"
PACKAGE_NAME="warp-terminal.pkg.tar.zst"

# Ensure Downloads directory exists
mkdir -p "$DOWNLOAD_DIR"

# Download the package
download_package "$DOWNLOAD_URL" "$PACKAGE_NAME" "$DOWNLOAD_DIR"

# Add Warp's repository
add_repository "warpdotdev" "https://releases.warp.dev/linux/pacman/\$repo/\$arch"

# Install the package
install_local_package "$DOWNLOAD_DIR/$PACKAGE_NAME"

# Clean up the downloaded file
echo -e "\e[32mCleaning up\e[0m"
rm "$DOWNLOAD_DIR/$PACKAGE_NAME"

# Success message.
echo -e "\e[32mWarp Terminal has been installed\e[0m"
