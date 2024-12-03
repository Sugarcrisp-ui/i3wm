#!/bin/bash

# Color definitions
GREEN=$(tput setaf 2)
BLUE=$(tput setaf 4)
CYAN=$(tput setaf 6)
YELLOW=$(tput setaf 3)
RESET=$(tput sgr0)

# Configuration
EXTERNAL_DRIVE="/dev/sdc1"
UUID="8e7807ea-b45b-4cfe-a767-727994c3d5cd"
MOUNT_POINT="/run/media/brett/backup"
KEYFILE="/etc/luks_keyfile"
KEYFILE_SIZE=4096
MAPPER_NAME="/dev/mapper/backup_crypt"

echo "${BLUE}################################################################"
echo "                    Setting Up Encrypted Drive"
echo "################################################################${RESET}"

# Generate keyfile
echo "${CYAN}Generating keyfile...${RESET}"
dd if=/dev/urandom of="$KEYFILE" bs=1 count=$KEYFILE_SIZE
chmod 400 "$KEYFILE"

# Add keyfile to LUKS
echo "${YELLOW}Adding keyfile to LUKS. Enter your existing LUKS password:${RESET}"
sudo cryptsetup luksAddKey "$EXTERNAL_DRIVE" "$KEYFILE"

# Setup mount point and open LUKS partition
echo "${CYAN}Setting up mount point and opening LUKS partition...${RESET}"
sudo mkdir -p "$MOUNT_POINT"
sudo cryptsetup luksOpen "$EXTERNAL_DRIVE" backup_crypt --key-file "$KEYFILE"

# Mount encrypted partition
echo "${CYAN}Mounting encrypted partition...${RESET}"
sudo mount "$MAPPER_NAME" "$MOUNT_POINT"

# Configure automatic mounting
echo "${CYAN}Configuring automatic mounting...${RESET}"
echo "UUID=$UUID none $MAPPER_NAME auto,noauto,x-systemd.automount,x-systemd.device-timeout=10,x-systemd.mount-timeout=10,errors=remount-ro 0 2" | sudo tee -a /etc/fstab
echo "backup_crypt UUID=$UUID $KEYFILE luks" | sudo tee -a /etc/crypttab

echo "${GREEN}################################################################"
echo "          Drive setup complete. Reboot to test automatic mounting."
echo "################################################################${RESET}"