#!/bin/bash

# Author: Brett Crisp
# Main installation script for i3 on Arch Linux

# Keep sudo alive in background
function keep_sudo_alive() {
    while true; do
        sudo -v
        sleep 60
    done &
    SUDO_PID=$!
    trap "kill $SUDO_PID" EXIT
}

# Start the sudo keeper
keep_sudo_alive

# Color definitions using tput
GREEN=$(tput setaf 2)
BLUE=$(tput setaf 4)
CYAN=$(tput setaf 6)
RED=$(tput setaf 1)
RESET=$(tput sgr0)

# Logging function
LOG_FILE="/tmp/i3-install.log"
log_error() {
    echo "${RED}[ERROR] $1${RESET}" | tee -a "$LOG_FILE"
    exit 1
}

echo "${BLUE}################################################################"
echo "                    Starting i3 Installation"
echo "################################################################${RESET}"

# Parallel downloads config
echo "${CYAN}Configuring parallel downloads...${RESET}"
sudo sed -i 's/ParallelDownloads = 8/ParallelDownloads = 20/g; s/#ParallelDownloads = 5/ParallelDownloads = 20/g' /etc/pacman.conf || log_error "Failed to configure parallel downloads"

# Add Chaotic-AUR to pacman.conf
echo "${CYAN}Setting up Chaotic-AUR...${RESET}"
sudo pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com || log_error "Failed to receive Chaotic-AUR key"
sudo pacman-key --lsign-key 3056513887B78AEB || log_error "Failed to sign Chaotic-AUR key"
sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' --noconfirm || log_error "Failed to install chaotic-keyring"
sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic
