#!/usr/bin/env bash

# Author: Brett Crisp
# Unattended encrypted drive setup script.

declare -A colors=(
    [GREEN]="$(tput setaf 2)"
    [BLUE]="$(tput setaf 4)"
    [CYAN]="$(tput setaf 6)"
    [YELLOW]="$(tput setaf 3)"
    [RED]="$(tput setaf 1)"
    [RESET]="$(tput sgr0)"
)

function log_message() {
    local COLOR=${1}
    shift
    local MSG="${*}"
    echo -e "${colors[$COLOR]}${MSG}${RESET}"
}

# Configuration
EXTERNAL_DRIVE="/dev/sdc1"
UUID="8e7807ea-b45b-4cfe-a767-727994c3d5cd"
MOUNT_POINT="/run/media/brett/backup"
KEYFILE="/etc/luks_keyfile"
KEYFILE_SIZE=4096
MAPPER_NAME="backup_crypt"
LOGFILE="/var/log/encrypted_drive_setup.log"

# Redirect output to log for unattended runs
exec &> >(tee -a "$LOGFILE")

log_message "BLUE" "################################################################"
log_message "BLUE" "              Unattended Setup: Encrypted Drive"
log_message "BLUE" "################################################################"

# Ensure prerequisites
function ensure_prerequisites() {
    log_message "CYAN" "Checking prerequisites..."

    # Ensure necessary tools are installed
    for cmd in lsblk blkid cryptsetup dd mkdir mount; do
        if ! command -v "$cmd" &> /dev/null; then
            log_message "RED" "Error: Required tool $cmd is not installed."
            exit 1
        fi
    done
}

# Generate keyfile
function generate_keyfile() {
    if [ -e "$KEYFILE" ]; then
        log_message "YELLOW" "Keyfile already exists at $KEYFILE. Skipping creation."
    else
        log_message "CYAN" "Generating keyfile..."
        dd if=/dev/urandom of="$KEYFILE" bs=1 count=$KEYFILE_SIZE status=none
        chmod 400 "$KEYFILE"
    fi
}

# Configure LUKS encryption
function setup_luks() {
    log_message "CYAN" "Configuring LUKS encryption..."
    if ! output=$(cryptsetup luksAddKey "$EXTERNAL_DRIVE" "$KEYFILE" --batch-mode 2>&1); then
        log_message "RED" "Error: Failed to add keyfile to LUKS - $output"
        exit 1
    fi
}

# Open encrypted drive
function open_drive() {
    log_message "CYAN" "Opening LUKS partition..."
    if ! output=$(cryptsetup luksOpen "$EXTERNAL_DRIVE" "$MAPPER_NAME" --key-file "$KEYFILE" 2>&1); then
        log_message "RED" "Error: Failed to open LUKS partition - $output"
        exit 1
    fi
}

# Mount the drive
function mount_drive() {
    log_message "CYAN" "Creating mount point and mounting drive..."
    mkdir -p "$MOUNT_POINT"
    if ! output=$(mount "/dev/mapper/$MAPPER_NAME" "$MOUNT_POINT" 2>&1); then
        log_message "RED" "Error: Failed to mount encrypted partition - $output"
        exit 1
    fi
}

# Update system configuration
function configure_automatic_mounting() {
    log_message "CYAN" "Configuring /etc/fstab and /etc/crypttab..."

    # Update crypttab
    if ! grep -q "^$MAPPER_NAME" /etc/crypttab; then
        echo "$MAPPER_NAME UUID=$UUID $KEYFILE luks" | tee -a /etc/crypttab > /dev/null
    else
        log_message "YELLOW" "Entry for $MAPPER_NAME already exists in /etc/crypttab."
    fi

    # Update fstab
    FS_TYPE=$(lsblk -no FSTYPE "/dev/mapper/$MAPPER_NAME")
    if ! grep -q "$MOUNT_POINT" /etc/fstab; then
        echo "/dev/mapper/$MAPPER_NAME $MOUNT_POINT $FS_TYPE defaults,x-systemd.automount,x-systemd.device-timeout=10 0 2" | tee -a /etc/fstab > /dev/null
    else
        log_message "YELLOW" "Entry for $MOUNT_POINT already exists in /etc/fstab."
    fi
}

# Main script execution
ensure_prerequisites
generate_keyfile
setup_luks
open_drive
mount_drive
configure_automatic_mounting

log_message "GREEN" "################################################################"
log_message "GREEN" "         Setup Complete. Reboot to test auto-mounting."
log_message "GREEN" "################################################################"