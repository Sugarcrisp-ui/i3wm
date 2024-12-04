#!/bin/bash

# Author: Brett Crisp

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
RESET=$(tput sgr0)

echo "${BLUE}################################################################"
echo "                    Starting Installation Script"
echo "################################################################${RESET}"

# Parallel downloads config
echo "${CYAN}Configuring parallel downloads...${RESET}"
sudo sed -i 's/ParalleDownloads = 8/ParalleDownloads = 20/g; s/#ParalleDownloads = 5/ParalleDownloads = 20/g' /etc/pacman.conf

# Update system
echo "${CYAN}Updating system...${RESET}"
sudo pacman -Syyu --noconfirm

# Make scripts executable and change directory
chmod +x Personal/*.sh
cd Personal

# Simplified script array
scripts=(
  "080-i3wm-install"
  "090-git-clone-dotfiles"
  "092-automount-remote-drive"
  "095-create-symlinks-from-dotfiles"
  "666-remove-software"
# clean arch install only  "105-install-arcolinux-software"
  "110-install-core-software"
  "115-warp-terminal-install"
  "120-sound"
  "160-laptop"
  "200-software-AUR-repo"
  "250-software-flatpak"
  "130-bluetooth"
  "260-enable-timeshift"
  "270-enable-hblock"
  "700-installing-fonts"
  "900-install-personal-settings-folders"
# currently using dotfiles  "905-install-personal-settings-bookmarks"
  "940-btrfs-setup"
# may not be relevent anymore "950-fix-pamac-aur"
)

# Execute scripts with colorful progress indicator
total=${#scripts[@]}
for i in "${!scripts[@]}"; do
    current=$((i + 1))
    echo "${GREEN}[$current/$total] Running ${scripts[$i]}.sh${RESET}"
    bash "${scripts[$i]}.sh"
done

# Enable core services
echo "${CYAN}Enabling core services...${RESET}"
sudo systemctl enable cronie.service
sudo mkinitcpio -P 

echo "${GREEN}################################################################"
echo "                    Installation Complete!"
echo "################################################################${RESET}"