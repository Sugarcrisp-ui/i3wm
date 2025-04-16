#!/bin/bash

# Author: Brett Crisp
# Configures LUKS-encrypted drive for auto-decrypt and automount, syncs SSH/cron

# Color definitions
GREEN=$(tput setaf 2)
CYAN=$(tput setaf 6)
YELLOW=$(tput setaf 3)
RESET=$(tput sgr0)

# Configuration
EXTERNAL_UUID="your-drive-uuid-here" # Update with blkid
MOUNT_POINT="/run/media/brett/backup"
MAPPER_NAME="backup_crypt"
KEYFILE="/etc/luks_keyfile"

echo "${CYAN}################################################################"
echo "                    Configuring Backup Drive"
echo "################################################################${RESET}"

# Find the device by UUID
EXTERNAL_DRIVE=$(blkid -U "$EXTERNAL_UUID" 2>/dev/null)

if [ ! -b "$EXTERNAL_DRIVE" ]; then
    echo "${YELLOW}Device with UUID $EXTERNAL_UUID not found. Skipping...${RESET}"
    exit 0
fi

# Ensure required tools
for cmd in cryptsetup mount dd tar rsync; do
    command -v "$cmd" &>/dev/null || {
        echo "${CYAN}Installing $cmd...${RESET}"
        sudo pacman -S --noconfirm "$cmd" || {
            echo "${YELLOW}Failed to install $cmd${RESET}"
            exit 1
        }
    }
done

# Generate keyfile if needed
if [ ! -f "$KEYFILE" ]; then
    echo "${CYAN}Generating keyfile...${RESET}"
    sudo dd if=/dev/urandom of="$KEYFILE" bs=1 count=4096 status=none || {
        echo "${YELLOW}Failed to generate keyfile${RESET}"
        exit 1
    }
    sudo chmod 400 "$KEYFILE"
    echo "${CYAN}Adding keyfile to LUKS. Enter your existing password:${RESET}"
    sudo cryptsetup luksAddKey "$EXTERNAL_DRIVE" "$KEYFILE" || {
        echo "${YELLOW}Failed to add keyfile${RESET}"
        exit 1
    }
fi

# Open LUKS partition
echo "${CYAN}Opening LUKS partition...${RESET}"
sudo cryptsetup luksOpen --key-file "$KEYFILE" "$EXTERNAL_DRIVE" "$MAPPER_NAME" || {
    echo "${YELLOW}Failed to open LUKS partition${RESET}"
    exit 1
}

# Mount
sudo mkdir -p "$MOUNT_POINT"
sudo mount "/dev/mapper/$MAPPER_NAME" "$MOUNT_POINT" || {
    echo "${YELLOW}Failed to mount partition${RESET}"
    exit 1
}

# Configure crypttab for auto-decrypt
if ! grep -q "$MAPPER_NAME" /etc/crypttab; then
    echo "${CYAN}Configuring crypttab for auto-decrypt...${RESET}"
    echo "$MAPPER_NAME UUID=$EXTERNAL_UUID $KEYFILE luks" | sudo tee -a /etc/crypttab >/dev/null
fi

# Configure fstab for automount
if ! grep -q "$MOUNT_POINT" /etc/fstab; then
    echo "${CYAN}Configuring fstab for automount...${RESET}"
    FS_UUID=$(blkid -s UUID -o value "/dev/mapper/$MAPPER_NAME")
    echo "UUID=$FS_UUID $MOUNT_POINT auto defaults,x-systemd.automount,x-systemd.device-timeout=10,x-systemd.mount-timeout=10,errors=remount-ro 0 2" | sudo tee -a /etc/fstab >/dev/null
fi

# Ensure mount point permissions
sudo chown brett:brett "$MOUNT_POINT"

# Sync SSH
SSH_BACKUP=$(ls -t "$MOUNT_POINT/system-files/ssh/ssh."*.tar.gz 2>/dev/null | head -n 1)
if [ -f "$SSH_BACKUP" ]; then
    echo "${CYAN}Syncing latest SSH backup: $SSH_BACKUP...${RESET}"
    mkdir -p "$HOME/.ssh"
    tar -xzf "$SSH_BACKUP" -C "$HOME/.ssh/"
    chmod 700 "$HOME/.ssh"
    chmod 600 "$HOME/.ssh"/*
else
    echo "${YELLOW}No SSH backup found${RESET}"
fi

# Sync cron
CRON_DIR="$MOUNT_POINT/system-files/cron"
if [ -d "$CRON_DIR" ]; then
    echo "${CYAN}Syncing cron files...${RESET}"
    sudo mkdir -p /var/spool/cron
    USER_CRON=$(ls -t "$CRON_DIR/crontab.user."*.TIMESTAMP 2>/dev/null | head -n 1)
    ROOT_CRON=$(ls -t "$CRON_DIR/crontab.root."*.TIMESTAMP 2>/dev/null | head -n 1)
    [ -f "$USER_CRON" ] && {
        sudo cp "$USER_CRON" /var/spool/cron/brett
        sudo chown brett:brett /var/spool/cron/brett
        sudo chmod 600 /var/spool/cron/brett
        echo "${GREEN}Restored user crontab${RESET}"
    } || echo "${YELLOW}No user crontab found${RESET}"
    [ -f "$ROOT_CRON" ] && {
        sudo cp "$ROOT_CRON" /var/spool/cron/root
        sudo chown root:root /var/spool/cron/root
        sudo chmod 600 /var/spool/cron/root
        echo "${GREEN}Restored root crontab${RESET}"
    } || echo "${YELLOW}No root crontab found${RESET}"
else
    echo "${YELLOW}No cron directory found${RESET}"
fi

echo "${GREEN}################################################################"
echo "                    Backup Drive Setup Complete!"
echo "################################################################${RESET}"
