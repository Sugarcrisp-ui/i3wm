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

# Check and set ParallelDownloads
echo "${CYAN}Checking ParallelDownloads in pacman.conf...${RESET}"
if ! grep -q "ParallelDownloads = 20" /etc/pacman.conf; then
    echo "${CYAN}Setting ParallelDownloads to 20...${RESET}"
    sudo sed -i 's/ParallelDownloads = 5/ParallelDownloads = 20/g; s/#ParallelDownloads = 5/ParallelDownloads = 20/g' /etc/pacman.conf || log_error "Failed to configure parallel downloads"
else
    echo "${GREEN}ParallelDownloads already set to 20${RESET}"
fi

# Check if Chaotic-AUR is already configured
if ! grep -q "\[chaotic-aur\]" /etc/pacman.conf; then
    echo "${CYAN}Setting up Chaotic-AUR...${RESET}"
    sudo pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com || log_error "Failed to receive Chaotic-AUR key"
    sudo pacman-key --lsign-key 3056513887B78AEB || log_error "Failed to sign Chaotic-AUR key"
    sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' --noconfirm || log_error "Failed to install chaotic-keyring"
    sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst' --noconfirm || log_error "Failed to install chaotic-mirrorlist"
    echo -e "\n[chaotic-aur]\nInclude = /etc/pacman.d/chaotic-mirrorlist" | sudo tee -a /etc/pacman.conf || log_error "Failed to configure Chaotic-AUR"
else
    echo "${GREEN}Chaotic-AUR already configured${RESET}"
fi

# Check if Nemesis repo is already configured
if ! grep -q "\[nemesis_repo\]" /etc/pacman.conf; then
    echo "${CYAN}Setting up Nemesis repository...${RESET}"
    sudo pacman-key --recv-key 74F5DE85A506BF64 --keyserver keyserver.ubuntu.com || log_error "Failed to receive Nemesis key"
    sudo pacman-key --lsign-key 74F5DE85A506BF64 || log_error "Failed to sign Nemesis key"
    echo -e "\n[nemesis_repo]\nSigLevel = PackageRequired DatabaseNever\nServer = https://erikdubois.github.io/nemesis_repo/x86_64" | sudo tee -a /etc/pacman.conf || log_error "Failed to configure Nemesis repo"
else
    echo "${GREEN}Nemesis repo already configured${RESET}"
fi

# Check if sugarcrisp-ui repo is already configured
#if ! grep -q "\[sugarcrisp-ui\]" /etc/pacman.conf; then
#    echo "${CYAN}Setting up sugarcrisp-ui repository...${RESET}"
#    sudo pacman-key --recv-key 21852D5ABA13AB93DCE8D7E0BE10811EE3295638 --keyserver keyserver.ubuntu.com || log_error "Failed to receive sugarcrisp-ui key"
#    sudo pacman-key --lsign-key 21852D5ABA13AB93DCE8D7E0BE10811EE3295638 || log_error "Failed to sign sugarcrisp-ui key"
#    echo -e "\n[sugarcrisp-ui]\nSigLevel = Optional TrustedOnly\nServer = https://sugarcrisp-ui.github.io/my_repo" | sudo tee -a /etc/pacman.conf || log_error "Failed to configure sugarcrisp-ui repo"
#else
#    echo "${GREEN}sugarcrisp-ui repo already configured${RESET}"
#fi

# Import Balló György key for Arch packages
echo "${CYAN}Importing Balló György key...${RESET}"
sudo pacman-key --recv-key 632C3CC0D1C9CAF6 --keyserver hkps://keys.openpgp.org || echo "${YELLOW}Warning: Failed to import Balló György key${RESET}"
sudo pacman-key --lsign-key 632C3CC0D1C9CAF6 || echo "${YELLOW}Warning: Failed to sign Balló György key${RESET}"

# Sync package database before installing paru
echo "${CYAN}Syncing package database...${RESET}"
sudo pacman -Syy || log_error "Failed to sync package database"

# Install paru
echo "${CYAN}Installing paru...${RESET}"
sudo pacman -S --noconfirm --needed paru || log_error "Failed to install paru"

# Import arc-gtk-theme key to avoid prompts
echo "${CYAN}Importing arc-gtk-theme key...${RESET}"
sudo pacman-key --recv-key 31743CDF250EF641E57503E5FAEDBC4FB5AA3B17 --keyserver keyserver.ubuntu.com || echo "${YELLOW}Warning: Failed to import arc-gtk-theme key${RESET}"
sudo pacman-key --lsign-key 31743CDF250EF641E57503E5FAEDBC4FB5AA3B17 || echo "${YELLOW}Warning: Failed to sign arc-gtk-theme key${RESET}"

# Update system
echo "${CYAN}Updating system...${RESET}"
sudo pacman -Syyu --noconfirm || log_error "Failed to update system"
paru -Syu --noconfirm || log_error "Failed to update AUR packages"

# Make scripts executable and change directory
chmod +x Personal/*.sh || log_error "Failed to make scripts executable"
cd Personal || log_error "Failed to change to Personal directory"

# Script array
scripts=(
	"085-move-home-to-luks"
    "090-setup-dotfiles"
    "092-configure-backup-drive"
    "100-install-packages"
#    "106-install-archlinux-logout"
    "115-warp-terminal-install"
    "150-enable-services"
    "160-laptop"
#    "800-install-sddm-themes"
    "900-configure-personal-settings"
    "950-cleanup"
)

# Execute scripts with progress indicator
total=${#scripts[@]}
for i in "${!scripts[@]}"; do
    current=$((i + 1))
    echo "${GREEN}[$current/$total] Running ${scripts[$i]}.sh${RESET}"
    if ! bash "${scripts[$i]}.sh"; then
        log_error "Error executing ${scripts[$i]}.sh"
    fi
done

echo "${GREEN}################################################################"
echo "                    i3 Installation Complete!"
echo "################################################################${RESET}"

# Testing note
echo "${CYAN}Note: To validate the installation, run 'i3-test/Personal/960-validate.sh' manually after rebooting.${RESET}"
