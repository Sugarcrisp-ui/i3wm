#!/bin/bash

# Author: Brett Crisp
# Configures LUKS-encrypted drive and syncs SSH/cron

# Color definitions
GREEN=$(tput setaf 2)
CYAN=$(tput setaf 6)
YELLOW=$(tput setaf 3)
RESET=$(tput sgr0)

# Configuration (replace with your drive's UUID)
EXTERNAL_UUID="your-drive-uuid-here" # Update this with blkid on your host
MOUNT_POINT="/run/media/brett/backup"
KEYFILE="/etc/luks_keyfile"
KEYFILE_SIZE=4096
MAPPER_NAME="backup_crypt"

echo "${CYAN}################################################################"
echo "                    Configuring Backup Drive"
echo "################################################################${RESET}"

# Find the device by UUID
EXTERNAL_DRIVE=$(blkid -U "$EXTERNAL_UUID" 2>/dev/null)

if [ ! -b "$EXTERNAL_DRIVE" ]; then
    echo "${YELLOW}Device with UUID $EXTERNAL_UUID not found. Skipping drive setup...${RESET}"
    exit 0
fi

# Install required tools
for cmd in cryptsetup dd mount blkid rsync; do
    pacman -Qi "$cmd" &>/dev/null || sudo pacman -S --noconfirm "$cmd" || {
        echo "${YELLOW}Failed to install $cmd${RESET}"
        exit 1
    }
done

# Verify LUKS
if ! cryptsetup isLuks "$EXTERNAL_DRIVE"; then
    echo "${YELLOW}Device $EXTERNAL_DRIVE is not LUKS-encrypted${RESET}"
    exit 1
fi

# Generate keyfile if needed
if [ ! -f "$KEYFILE" ]; then
    echo "${CYAN}Generating keyfile...${RESET}"
    dd if=/dev/urandom of="$KEYFILE" bs=1 count="$KEYFILE_SIZE" || exit 1
    chmod 400 "$KEYFILE"
fi

# Add keyfile to LUKS
echo "${CYAN}Adding keyfile to LUKS. Enter your existing LUKS password:${RESET}"
cryptsetup luksAddKey "$EXTERNAL_DRIVE" "$KEYFILE" || exit 1

# Open LUKS partition
echo "${CYAN}Opening LUKS partition...${RESET}"
cryptsetup luksOpen "$EXTERNAL_DRIVE" "$MAPPER_NAME" || exit 1

# Create and mount
mkdir -p "$MOUNT_POINT"
mount "/dev/mapper/$MAPPER_NAME" "$MOUNT_POINT" || {
    echo "${YELLOW}Failed to mount partition${RESET}"
    exit 1
}

# Configure crypttab and fstab
LUKS_UUID=$(blkid -s UUID -o value "$EXTERNAL_DRIVE")
FS_UUID=$(blkid -s UUID -o value "/dev/mapper/$MAPPER_NAME")
echo "$MAPPER_NAME UUID=$LUKS_UUID $KEYFILE luks" | sudo tee -a /etc/crypttab >/dev/null
echo "UUID=$FS_UUID $MOUNT_POINT auto defaults,noauto,x-systemd.automount,x-systemd.device-timeout=10,x-systemd.mount-timeout=10,errors=remount-ro 0 2" | sudo tee -a /etc/fstab >/dev/null

# Sync SSH and cron
if [ -d "$MOUNT_POINT/.ssh" ]; then
    echo "${CYAN}Syncing SSH files...${RESET}"
    mkdir -p "$HOME/.ssh"
    rsync -avz --delete "$MOUNT_POINT/.ssh/" "$HOME/.ssh/"
    chmod 700 "$HOME/.ssh"
    chmod 600 "$HOME/.ssh"/*
else
    echo "${YELLOW}No .ssh directory found on drive, skipping SSH sync${RESET}"
fi

if [ -d "$MOUNT_POINT/cron" ]; then
    echo "${CYAN}Syncing cron files...${RESET}"
    sudo mkdir -p /var/spool/cron
    [ -f "$MOUNT_POINT/cron/brett" ] && {
        sudo rsync -avz --delete "$MOUNT_POINT/cron/brett" /var/spool/cron/brett
        sudo chown brett:brett /var/spool/cron/brett
        sudo chmod 600 /var/spool/cron/brett
    }
    [ -f "$MOUNT_POINT/cron/root" ] && {
        sudo rsync -avz --delete "$MOUNT_POINT/cron/root" /var/spool/cron/root
        sudo chown root:root /var/spool/cron/root
        sudo chmod 600 /var/spool/cron/root
    }
else
    echo "${YELLOW}No cron directory found on drive, skipping cron sync${RESET}"
fi

echo "${GREEN}################################################################"
echo "                    Backup Drive Setup Complete!"
echo "################################################################${RESET}"
