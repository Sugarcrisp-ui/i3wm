#!/bin/bash

set -e

# Function for colored logging
log_with_color() {
    tput setaf 11; echo "################################################################"; tput sgr0
    tput setaf 11; echo "$1"; tput sgr0
    tput setaf 11; echo "################################################################"; tput sgr0
}

# Function to create a symlink and set permissions
create_cron_symlink() {
    local source="$1"
    local dest="$2"
    local owner="$3"
    
    # Remove existing file if it's not a symlink or if it's a broken symlink
    if [ -e "$dest" ] && [ ! -L "$dest" ] || [ -L "$dest" ] && ! [ -e "$dest" ]; then
        sudo rm "$dest"
    fi
    
    # Create the symlink
    sudo ln -s "$source" "$dest" || { echo "Failed to create symlink for $dest"; exit 1; }
    
    # Set ownership and permissions
    sudo chown "$owner":"$owner" "$dest"
    sudo chmod 600 "$dest"
    
    echo "Symlink created and permissions set for $dest"
}

# Create symlinks for cron files
log_with_color "Setting up cron file symlinks"

# Ensure the cron directory exists
sudo mkdir -p /var/spool/cron

# For user 'brett'
if [ -f "$HOME/dotfiles/cron/brett" ]; then
    create_cron_symlink "$HOME/dotfiles/cron/brett" "/var/spool/cron/brett" "brett"
else
    echo "Warning: Cron file for brett not found in dotfiles/cron."
fi

# For user 'root'
if [ -f "$HOME/dotfiles/cron/root" ]; then
    create_cron_symlink "$HOME/dotfiles/cron/root" "/var/spool/cron/root" "root"
else
    echo "Warning: Cron file for root not found in dotfiles/cron."
fi

# Restart cron service to ensure it picks up the new configuration
log_with_color "Restarting cron service"
sudo systemctl restart cronie.service

log_with_color "Cron symlink setup completed"
