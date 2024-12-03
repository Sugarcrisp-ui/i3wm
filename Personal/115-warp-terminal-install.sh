#!/bin/bash

# Author: Brett Crisp

# Color definitions
GREEN=$(tput setaf 2)
BLUE=$(tput setaf 4)
CYAN=$(tput setaf 6)
RESET=$(tput sgr0)

# Download and installation paths
DOWNLOAD_DIR="$HOME/Downloads"
DOWNLOAD_URL="https://app.warp.dev/download?package=pacman"
PACKAGE_NAME="warp-terminal.pkg.tar.zst"

echo "${BLUE}################################################################"
echo "                Installing Warp Terminal"
echo "################################################################${RESET}"

# Download Warp Terminal
echo "${CYAN}Downloading Warp Terminal...${RESET}"
curl -L -o "$DOWNLOAD_DIR/$PACKAGE_NAME" "$DOWNLOAD_URL"

# Install package
echo "${CYAN}Installing Warp Terminal...${RESET}"
sudo pacman -U --noconfirm "$DOWNLOAD_DIR/$PACKAGE_NAME"

# Cleanup
echo "${CYAN}Cleaning up downloaded files...${RESET}"
rm "$DOWNLOAD_DIR/$PACKAGE_NAME"

echo "${GREEN}################################################################"
echo "                Warp Terminal Installation Complete!"
echo "################################################################${RESET}"