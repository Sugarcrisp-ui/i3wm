#!/bin/bash

# Author: Brett Crisp
# Simplified script to download and install Warp Terminal on Arch Linux.

# Function to handle errors
handle_error() {
  echo -e "\e[31mAn error occurred while installing Warp Terminal. Please check the output and try again.\e[0m"
  exit 1
}

# Set up error handling
trap 'handle_error' ERR

# Define paths and URLs
DOWNLOAD_DIR="$HOME/Downloads"
DOWNLOAD_URL="https://app.warp.dev/download?package=pacman"
PACKAGE_NAME="warp-terminal.pkg.tar.zst"

# Download the package
echo -e "\e[32mDownloading Warp Terminal package\e[0m"
curl -L -o "$DOWNLOAD_DIR/$PACKAGE_NAME" "$DOWNLOAD_URL"

# Install the package
echo -e "\e[32mInstalling Warp Terminal\e[0m"
sudo pacman -U --noconfirm "$DOWNLOAD_DIR/$PACKAGE_NAME"

# Clean up the downloaded file
echo -e "\e[32mCleaning up downloaded package\e[0m"
rm "$DOWNLOAD_DIR/$PACKAGE_NAME"

# Success message
echo -e "\e[32mWarp Terminal has been installed successfully!\e[0m"
