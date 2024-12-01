#!/bin/bash
# The set command is used to determine action if error
# is encountered.  (-e) will stop and exit (+e) will
# continue with the script.
set -e
trap 'echo "An error occurred in $0 at line $LINENO. Exiting." >&2; exit 1' ERR

##################################################################################################################

tput setaf 11;
echo "################################################################"
echo "Creating personal folders"
echo ""
echo "################################################################"
tput sgr0

for dir in "Appimages" "Shared"; do
    if ! mkdir -p "$HOME/$dir" 2>/dev/null; then
        echo "Warning: Failed to create directory $HOME/$dir"
    fi
done

tput setaf 11;
echo "################################################################"
echo "Syncing .ssh directory"
echo ""
echo "################################################################"
tput sgr0

# Define source and destination directories
SOURCE_SSH="/run/media/brett/backup/.ssh"
DEST_SSH="$HOME/.ssh"

# Ensure destination directory exists
if [ ! -d "$DEST_SSH" ]; then
    mkdir -p "$DEST_SSH"
    chmod 700 "$DEST_SSH"
    echo "Created directory $DEST_SSH with proper permissions."
fi

# Sync source to destination
if [ -d "$SOURCE_SSH" ]; then
    rsync -avz --delete "$SOURCE_SSH/" "$DEST_SSH/"
    chmod 700 "$DEST_SSH"
    chmod 600 "$DEST_SSH"/*
    echo "Synced $SOURCE_SSH to $DEST_SSH with proper permissions."
else
    echo "Warning: Source .ssh directory $SOURCE_SSH does not exist."
fi

tput setaf 11;
echo "################################################################"
echo "Copying rc.local to /etc/"
echo ""
echo "################################################################"
tput sgr0

# Check if rc.local exists before trying to backup
if [ -f "/etc/rc.local" ]; then
    sudo cp /etc/rc.local "/etc/rc.local.$(date +"%Y%m%d%H%M%S").bak"
else
    echo "Warning: /etc/rc.local does not exist. No backup created."
fi

# This restores or installs my rc.local settings
SOURCE_RC_LOCAL="~/i3wm/personal-settings/etc/rc.local"
if [ -f "$SOURCE_RC_LOCAL" ]; then
    if ! sudo rsync -avz --delete "$SOURCE_RC_LOCAL" /etc/; then
        echo "Error: Failed to copy rc.local to /etc/"
    else
        sudo chown -R root:root /etc/rc.local
        sudo chmod 755 /etc/rc.local  # rc.local typically needs execute permission
        echo "rc.local has been copied to /etc/ and permissions set."
    fi
else
    echo "Error: Source rc.local not found at $SOURCE_RC_LOCAL."
fi

tput setaf 11;
echo "################################################################"
echo "Configuring crontabs"
echo ""
echo "################################################################"
tput sgr0

# Directory where your cron files are stored
CRON_SOURCE_DIR="/run/media/brett/backup/cron"
CRON_DEST_DIR="/var/spool/cron"

# Ensure the source directory exists
if [ -d "$CRON_SOURCE_DIR" ]; then
    # Create destination directory if it doesn't exist (though it should already exist)
    sudo mkdir -p "$CRON_DEST_DIR"

    # Copy user cron
    USER_CRON_FILE="$CRON_SOURCE_DIR/brett"
    if [ -f "$USER_CRON_FILE" ]; then
        sudo rsync -avz --delete "$USER_CRON_FILE" "$CRON_DEST_DIR/brett"
        sudo chown brett:brett "$CRON_DEST_DIR/brett"
        sudo chmod 600 "$CRON_DEST_DIR/brett"
        echo "User cron job configuration from $USER_CRON_FILE has been applied."
    else
        echo "Warning: User cron configuration file $USER_CRON_FILE does not exist."
    fi

    # Copy root cron
    ROOT_CRON_FILE="$CRON_SOURCE_DIR/root"
    if [ -f "$ROOT_CRON_FILE" ]; then
        sudo rsync -avz --delete "$ROOT_CRON_FILE" "$CRON_DEST_DIR/root"
        sudo chown root:root "$CRON_DEST_DIR/root"
        sudo chmod 600 "$CRON_DEST_DIR/root"
        echo "Root cron job configuration from $ROOT_CRON_FILE has been applied."
    else
        echo "Warning: Root cron configuration file $ROOT_CRON_FILE does not exist."
    fi
else
    echo "Warning: Cron source directory $CRON_SOURCE_DIR does not exist."
fi

tput setaf 11;
echo "################################################################"
echo "Setting up Polybar"
echo ""
echo "################################################################"
tput sgr0

# Ensure Polybar launch script is executable
if [ -f "$HOME/.config/polybar/launch.sh" ]; then
    chmod +x "$HOME/.config/polybar/launch.sh"
    echo "Made Polybar launch script executable."
else
    echo "Warning: Polybar launch script not found at $HOME/.config/polybar/launch.sh"
fi

echo "################################################################"
echo "Script execution completed"
echo "################################################################"
tput sgr0
exit 0
