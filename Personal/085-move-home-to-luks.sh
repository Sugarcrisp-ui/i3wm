#!/bin/bash

# Author: Brett Crisp
# Moves /home to LUKS-encrypted HDD (/dev/sda1), creates LUKS if needed

# Color definitions
GREEN=$(tput setaf 2)
CYAN=$(tput setaf 6)
YELLOW=$(tput setaf 3)
RED=$(tput setaf 1)
RESET=$(tput sgr0)

echo "${CYAN}################################################################"
echo "                    Moving /home to LUKS HDD"
echo "################################################################${RESET}"

# Configuration
LUKS_DEVICE="/dev/sda1"
MAPPER_NAME="luks-home"
MOUNT_POINT="/home"
TEMP_HOME="/mnt/temp-home"

# Ensure LUKS device exists
if [ ! -b "$LUKS_DEVICE" ]; then
    echo "${YELLOW}LUKS device $LUKS_DEVICE not found. Skipping...${RESET}"
    exit 0
fi

# Install rsync and cryptsetup if needed
for cmd in rsync cryptsetup; do
    command -v "$cmd" &>/dev/null || {
        echo "${CYAN}Installing $cmd...${RESET}"
        sudo pacman -S --noconfirm "$cmd" || { echo "${RED}Failed to install $cmd${RESET}"; exit 1; }
    }
done

# Check if device is LUKS
if ! sudo cryptsetup isLuks "$LUKS_DEVICE"; then
    echo "${YELLOW}Device $LUKS_DEVICE is not LUKS. Create LUKS volume? (WARNING: This will erase all data on $LUKS_DEVICE)${RESET}"
    read -p "Proceed? (y/N) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "${YELLOW}LUKS creation skipped. Exiting...${RESET}"
        exit 0
    fi
    echo "${CYAN}Creating LUKS volume on $LUKS_DEVICE...${RESET}"
    sudo cryptsetup luksFormat "$LUKS_DEVICE" || { echo "${RED}Failed to create LUKS volume${RESET}"; exit 1; }
    echo "${CYAN}Opening new LUKS volume...${RESET}"
    sudo cryptsetup luksOpen "$LUKS_DEVICE" "$MAPPER_NAME" || { echo "${RED}Failed to open new LUKS volume${RESET}"; exit 1; }
    echo "${CYAN}Formatting /dev/mapper/$MAPPER_NAME as ext4...${RESET}"
    sudo mkfs.ext4 "/dev/mapper/$MAPPER_NAME" || { echo "${RED}Failed to format${RESET}"; exit 1; }
else
    echo "${CYAN}Opening existing LUKS volume...${RESET}"
    sudo cryptsetup luksOpen "$LUKS_DEVICE" "$MAPPER_NAME" || {
        echo "${RED}Failed to open LUKS volume. Enter passphrase manually.${RESET}"
        exit 1
    }
fi

# Verify filesystem
if ! sudo file -s "/dev/mapper/$MAPPER_NAME" | grep -q ext4; then
    echo "${CYAN}Formatting /dev/mapper/$MAPPER_NAME as ext4...${RESET}"
    sudo mkfs.ext4 "/dev/mapper/$MAPPER_NAME" || { echo "${RED}Failed to format${RESET}"; exit 1; }
fi

# Backup current /home
echo "${CYAN}Backing up current /home...${RESET}"
sudo mkdir -p "$TEMP_HOME"
sudo cp -a /home/* "$TEMP_HOME/" || { echo "${RED}Failed to backup /home${RESET}"; exit 1; }

# Mount LUKS volume
echo "${CYAN}Mounting LUKS volume...${RESET}"
sudo mkdir -p /mnt/luks-home
sudo mount "/dev/mapper/$MAPPER_NAME" /mnt/luks-home || { echo "${RED}Failed to mount${RESET}"; exit 1; }

# Sync /home data
echo "${CYAN}Syncing /home to LUKS volume...${RESET}"
sudo rsync -a "$TEMP_HOME/" /mnt/luks-home/ || { echo "${RED}Failed to sync${RESET}"; exit 1; }

# Update /etc/fstab
echo "${CYAN}Updating /etc/fstab...${RESET}"
if ! grep -q "$MOUNT_POINT" /etc/fstab; then
    echo "/dev/mapper/$MAPPER_NAME $MOUNT_POINT ext4 defaults 0 2" | sudo tee -a /etc/fstab >/dev/null
fi

# Update /etc/crypttab
echo "${CYAN}Updating /etc/crypttab...${RESET}"
LUKS_UUID=$(sudo blkid -s UUID -o value "$LUKS_DEVICE")
if ! grep -q "$MAPPER_NAME" /etc/crypttab; then
    echo "$MAPPER_NAME UUID=$LUKS_UUID none luks" | sudo tee -a /etc/crypttab >/dev/null
fi

# Test mount
echo "${CYAN}Testing mount...${RESET}"
sudo umount /mnt/luks-home
sudo mount -a || { echo "${RED}Failed to mount /home${RESET}"; exit 1; }
ls /home && echo "${GREEN}/home mounted successfully${RESET}"

# Clean up
sudo rm -rf "$TEMP_HOME"

echo "${GREEN}################################################################"
echo "                    /home Moved to LUKS HDD!"
echo "################################################################${RESET}"
