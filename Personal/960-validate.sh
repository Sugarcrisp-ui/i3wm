#!/bin/bash

# Author: Brett Crisp
# Validates system state (run manually after installation)

# Color definitions
GREEN=$(tput setaf 2)
CYAN=$(tput setaf 6)
RED=$(tput setaf 1)
RESET=$(tput sgr0)

echo "${CYAN}################################################################"
echo "                    Validating Installation"
echo "################################################################${RESET}"

# Check services
for service in cronie bluetooth tlp sddm; do
    systemctl is-active --quiet "$service" && echo "${GREEN}$service is running${RESET}" || echo "${RED}$service is not running${RESET}"
done

# Check PulseAudio
systemctl --user is-active --quiet pulseaudio.service && echo "${GREEN}PulseAudio is running${RESET}" || echo "${RED}PulseAudio is not running${RESET}"

# Check symlinks
for link in ~/.bashrc ~/.config ~/.local; do
    [ -L "$link" ] && echo "${GREEN}$link is a symlink${RESET}" || echo "${RED}$link is not a symlink${RESET}"
done

# Check key packages
for pkg in i3-wm rofi polybar sddm timeshift; do
    pacman -Qi "$pkg" &>/dev/null && echo "${GREEN}$pkg is installed${RESET}" || echo "${RED}$pkg is not installed${RESET}"
done

# Check mount point (if applicable)
if mount | grep -q "/run/media/brett/backup"; then
    echo "${GREEN}Backup drive is mounted${RESET}"
else
    echo "${YELLOW}Backup drive is not mounted (expected in VM if not passed through)${RESET}"
fi

echo "${GREEN}################################################################"
echo "                    Validation Complete!"
echo "################################################################${RESET}"
