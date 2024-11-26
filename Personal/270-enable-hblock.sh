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

# This script will automate the setup of hblock on an Arch Linux system

log_with_color "Running hblock to update /etc/hosts"

# Run hblock with default settings to update /etc/hosts
sudo hblock

# Check if hblock ran successfully
if [ $? -eq 0 ]; then
    log_with_color "hblock has successfully updated the hosts file."
else
    log_with_color "There was an error running hblock. Please check the command output for details."
    exit 1
fi