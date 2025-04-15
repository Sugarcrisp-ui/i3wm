#!/bin/bash

# Author: Brett Crisp
# Installs Warp Terminal

# Color definitions
GREEN=$(tput setaf 2)
CYAN=$(tput setaf 6)
RED=$(tput setaf 1)
RESET=$(tput sgr0)

DOWNLOAD_DIR="$HOME/Downloads"
DOWNLOAD_URL="https://app.warp.dev/download?package=pacman"
PACKAGE_NAME="warp-terminal.pkg.tar.zst"

echo "${CYAN}################################################################"
echo "                    Installing Warp Terminal"
echo "################################################################${RESET}"

mkdir -p "$DOWNLOAD_DIR"
curl -L -o "$DOWNLOAD_DIR/$PACKAGE_NAME" "$DOWNLOAD_URL" || {
    echo "${RED}Failed to download Warp Terminal${RESET}"
    exit 1
}

sudo pacman -U --noconfirm "$DOWNLOAD_DIR/$PACKAGE_NAME" || {
    echo "${RED}Failed to install Warp Terminal${RESET}"
    exit 1
}

rm "$DOWNLOAD_DIR/$PACKAGE_NAME"

echo "${GREEN}################################################################"
echo "                    Warp Terminal Installation Complete!"
echo "################################################################${RESET}"
