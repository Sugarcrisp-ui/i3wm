#!/bin/bash

# Set up error handling
set -e
trap 'echo "An error occurred at line $LINENO. Exiting." >&2; exit 1' ERR

# Drive and mount point details
EXTERNAL_DRIVE="/dev/sdc1"
UUID="8e7807ea-b45b-4cfe-a767-727994c3d5cd"
MOUNT_POINT="/run/media/brett/backup"

# Keyfile details
KEYFILE="/etc/luks_keyfile"
KEYFILE_SIZE=4096  # Size in bytes, adjust if needed

# Function to log with color
log_with_color() {
    tput setaf 11; echo "################################################################"; tput sgr0
    tput setaf 11; echo "$1"; tput sgr0
    tput setaf 11; echo "################################################################"; tput sgr0
}

# Create keyfile
log_with_color "Generating keyfile..."
sudo dd if=/dev/urandom of="$KEYFILE" bs=1 count=$KEYFILE_SIZE
sudo chmod 400 "$KEYFILE"  # Make the keyfile read-only for security

# Add the keyfile to LUKS - this will prompt for the existing password
log_with_color "Adding keyfile to LUKS. Please enter your existing LUKS password when prompted..."
sudo cryptsetup luksAddKey "$EXTERNAL_DRIVE" "$KEYFILE"

# Check if adding was successful
if [ $? -ne 0 ]; then
    log_with_color "Failed to add keyfile to LUKS. Exiting."
    exit 1
fi

# Create the mount point if it doesn't exist
log_with_color "Creating mount point..."
sudo mkdir -p "$MOUNT_POINT"

# Open the LUKS encrypted partition using the keyfile
log_with_color "Opening encrypted partition..."
sudo cryptsetup luksOpen "$EXTERNAL_DRIVE" backup_crypt --key-file "$KEYFILE"

# Check if opening was successful
if [ $? -ne 0 ]; then
    log_with_color "Failed to open the encrypted partition."
    exit 1
fi

# Determine the mapper name (usually /dev/mapper/backup_crypt)
MAPPER_NAME="/dev/mapper/backup_crypt"

# Mount the encrypted partition
log_with_color "Mounting encrypted partition..."
sudo mount "$MAPPER_NAME" "$MOUNT_POINT"

# Check if mounting was successful
if [ $? -eq 0 ]; then
    log_with_color "Encrypted drive mounted successfully at $MOUNT_POINT."
else
    log_with_color "Failed to mount the encrypted drive."
    # Close the mapper device if mount fails
    sudo cryptsetup luksClose backup_crypt
    exit 1
fi

# Add entry to /etc/fstab for automatic mounting on reboot
log_with_color "Adding entry to fstab for auto-mount..."
echo "UUID=$UUID none $MAPPER_NAME auto,noauto,x-systemd.automount,x-systemd.device-timeout=10,x-systemd.mount-timeout=10,errors=remount-ro 0 2" | sudo tee -a /etc/fstab

# Add entry to /etc/crypttab for automatic unlocking with keyfile
log_with_color "Adding entry to crypttab for auto-unlock..."
echo "backup_crypt UUID=$UUID $KEYFILE luks" | sudo tee -a /etc/crypttab

log_with_color "Configuration for auto-mounting complete. Please reboot to test if the drive mounts automatically."