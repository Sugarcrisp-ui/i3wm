#!/bin/bash

# Set up error handling
set -e
trap 'echo "An error occurred at line $LINENO. Exiting." >&2; exit 1' ERR

# Function for colored logging
log_with_color() {
    tput setaf 11; echo "################################################################"; tput sgr0
    tput setaf 11; echo "$1"; tput sgr0
    tput setaf 11; echo "################################################################"; tput sgr0
}

# Timeshift configuration file path
CONFIG_FILE="/etc/timeshift/timeshift.json"

# Check if Timeshift is installed
if ! command -v timeshift &> /dev/null; then
    log_with_color "Timeshift is not installed. Please install it first."
    exit 1
fi

# Detect filesystem type of root
ROOT_FS=$(df -T / | awk 'END{print $2}')

# Set backup type based on filesystem
if [[ "$ROOT_FS" == "btrfs" ]]; then
    BACKUP_TYPE="btrfs"
else
    BACKUP_TYPE="rsync"
fi

# Default backup device, can be changed by user input
BACKUP_DEVICE="/dev/sdX1"

# Function to setup Timeshift
setup_timeshift() {
    log_with_color "Setting up Timeshift with $BACKUP_TYPE backup for $BACKUP_DEVICE"
    
    # Use sudo for running Timeshift with elevated privileges
    sudo timeshift --backup-device "$BACKUP_DEVICE" --backup-type $BACKUP_TYPE --schedule-daily 5 --schedule-weekly 2 --create

    # Check if setup was successful
    if [ $? -eq 0 ]; then
        log_with_color "Timeshift setup completed successfully for $BACKUP_TYPE."
    else
        log_with_color "Failed to setup Timeshift for $BACKUP_TYPE. Please check the configuration manually."
        exit 1
    fi
}

# Inform user if they wish to specify a different backup device
log_with_color "Using default backup device $BACKUP_DEVICE. If you wish to use a different device, please modify BACKUP_DEVICE variable in the script."
read -p "Press ENTER to continue with the default device or CTRL+C to abort and change the device..."

# Run the setup function
setup_timeshift