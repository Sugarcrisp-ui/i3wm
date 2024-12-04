#!/bin/bash

# Author: Brett Crisp

# Color definitions
GREEN=$(tput setaf 2)
BLUE=$(tput setaf 4)
CYAN=$(tput setaf 6)
YELLOW=$(tput setaf 3)
RESET=$(tput sgr0)

function log_message() {
    echo "${BLUE}################################################################"
    echo "$1"
    echo "################################################################${RESET}"
}

# Create personal directories
log_message "Creating Personal Folders"
for dir in "Appimages" "Shared"; do
    echo "${CYAN}Creating directory: $HOME/$dir${RESET}"
    mkdir -p "$HOME/$dir" 2>/dev/null
done

log_message "Removing ConkyZen Desktop Entry"
sudo rm -f /usr/share/applications/conkyzen.desktop

# Sync SSH directory if external drive is available
log_message "Checking SSH Configuration"
SOURCE_SSH="/run/media/brett/backup/.ssh"
DEST_SSH="$HOME/.ssh"

if [ ! -d "$DEST_SSH" ]; then
    echo "${CYAN}Creating SSH directory${RESET}"
    mkdir -p "$DEST_SSH"
    chmod 700 "$DEST_SSH"
fi

if [ -d "$SOURCE_SSH" ]; then
    echo "${CYAN}External drive found - syncing SSH files${RESET}"
    rsync -avz --delete "$SOURCE_SSH/" "$DEST_SSH/"
    chmod 700 "$DEST_SSH"
    chmod 600 "$DEST_SSH"/*
else
    echo "${YELLOW}External drive not found - skipping SSH sync${RESET}"
fi

# Setup rc.local
log_message "Setting Up rc.local"
[ -f "/etc/rc.local" ] && sudo cp /etc/rc.local "/etc/rc.local.$(date +"%Y%m%d%H%M%S").bak"

SOURCE_RC_LOCAL="~/i3wm/personal-settings/etc/rc.local"
if [ -f "$SOURCE_RC_LOCAL" ]; then
    echo "${CYAN}Copying and configuring rc.local${RESET}"
    sudo rsync -avz --delete "$SOURCE_RC_LOCAL" /etc/
    sudo chown root:root /etc/rc.local
    sudo chmod 755 /etc/rc.local
fi

# Configure crontabs if external drive is available
log_message "Checking Crontab Configuration"
CRON_SOURCE_DIR="/run/media/brett/backup/cron"
CRON_DEST_DIR="/var/spool/cron"

if [ -d "$CRON_SOURCE_DIR" ]; then
    echo "${CYAN}External drive found - configuring crontabs${RESET}"
    sudo mkdir -p "$CRON_DEST_DIR"
    
    # User cron
    if [ -f "$CRON_SOURCE_DIR/brett" ]; then
        echo "${CYAN}Setting up user crontab${RESET}"
        sudo rsync -avz --delete "$CRON_SOURCE_DIR/brett" "$CRON_DEST_DIR/brett"
        sudo chown brett:brett "$CRON_DEST_DIR/brett"
        sudo chmod 600 "$CRON_DEST_DIR/brett"
    fi
    
    # Root cron
    if [ -f "$CRON_SOURCE_DIR/root" ]; then
        echo "${CYAN}Setting up root crontab${RESET}"
        sudo rsync -avz --delete "$CRON_SOURCE_DIR/root" "$CRON_DEST_DIR/root"
        sudo chown root:root "$CRON_DEST_DIR/root"
        sudo chmod 600 "$CRON_DEST_DIR/root"
    fi
else
    echo "${YELLOW}External drive not found - skipping crontab setup${RESET}"
fi

# Setup Polybar
log_message "Setting Up Polybar"
[ -f "$HOME/.config/polybar/launch.sh" ] && {
    echo "${CYAN}Making Polybar launch script executable${RESET}"
    chmod +x "$HOME/.config/polybar/launch.sh"
}

echo "${GREEN}################################################################"
echo "                    Personal Settings Setup Complete!"
echo "################################################################${RESET}"