#!/bin/bash

# Function for colored logging
log_with_color() {
    tput setaf 11; echo "################################################################"; tput sgr0
    tput setaf 11; echo "$1"; tput sgr0
    tput setaf 11; echo "################################################################"; tput sgr0
}

# Ensure the destination directory exists in dotfiles
log_with_color "Ensuring ~/dotfiles/etc/ directory exists"
mkdir -p ~/dotfiles/etc

# Move rc.local to dotfiles directory
log_with_color "Moving /etc/rc.local to ~/dotfiles/etc/"
sudo cp --preserve=all /etc/rc.local ~/dotfiles/etc/rc.local
sudo rm /etc/rc.local

# Create symlink
log_with_color "Creating symlink for rc.local"
sudo ln -s ~/dotfiles/etc/rc.local /etc/rc.local

# Set permissions and ownership back to what they were
log_with_color "Setting correct permissions for the symlink"
sudo chown --reference=~/dotfiles/etc/rc.local /etc/rc.local
sudo chmod --reference=~/dotfiles/etc/rc.local /etc/rc.local

log_with_color "rc.local moved and symlink created with preserved permissions"
