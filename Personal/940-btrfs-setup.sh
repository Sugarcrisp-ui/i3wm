#!/bin/bash

# The set command is used to determine action if error
# is encountered.  (-e) will stop and exit (+e) will
# continue with the script.
set -e

##################################################################################################################

tput setaf 11;
echo "################################################################"
echo "Checking for Btrfs setup"
echo ""
echo "################################################################"
tput sgr0

# Function to check if the root filesystem is Btrfs
is_btrfs() {
    local root_fs=$(findmnt -o FSTYPE -n /)
    if [[ "$root_fs" == "btrfs" ]]; then
        return 0
    else
        return 1
    fi
}

# Check if the script is running as root. If not, exit.
if [[ $EUID -ne 0 ]]; then
   tput setaf 11;
   echo "################################################################"
   echo "This script must be run as root"
   echo "################################################################"
   tput sgr0
   exit 1
fi

if is_btrfs; then
    tput setaf 11;
    echo "################################################################"
    echo "Setting up Btrfs"
    echo ""
    echo "################################################################"
    tput sgr0

    # Mount all Btrfs partitions.
    mount -a

    # Function to check if a subvolume exists
    subvolume_exists() {
        local subvolume_path=$1
        if btrfs subvolume list -o / | grep -q "$subvolume_path"; then
            return 0
        else
            return 1
        fi
    }

    # Create snapshots subvolume if it doesn't exist
    if ! subvolume_exists "/.snapshots"; then
        btrfs subvolume create /.snapshots
        echo "Created /.snapshots subvolume"
    else
        echo "/.snapshots subvolume already exists"
    fi

    # Create home subvolume if it doesn't exist
    if ! subvolume_exists "/home"; then
        btrfs subvolume create /home
        echo "Created /home subvolume"
    else
        echo "/home subvolume already exists"
    fi

    # Set up default Btrfs mount options in /etc/fstab
    if ! grep -q "noatime,compress=zstd:1,autodefrag,space_cache=v2" /etc/fstab; then
        sed -i 's/noatime,compress=lzo,noatime/noatime,compress=zstd:1,autodefrag,space_cache=v2/g' /etc/fstab
        echo "Updated /etc/fstab with new mount options for Btrfs"
    else
        echo "Btrfs mount options in /etc/fstab are already set"
    fi

    # Mount all Btrfs partitions again to apply new mount options
    mount -a

    # Enable Btrfs maintenance
    sudo systemctl enable btrfs-scrub.timer
    sudo systemctl start btrfs-scrub.timer
    echo "Enabled and started btrfs-scrub.timer for maintenance"

    echo "################################################################"
    echo "#########            Btrfs setup completed               ################"
    echo "################################################################"
else
    tput setaf 3;
    echo "################################################################"
    echo "System is not using Btrfs. Skipping Btrfs setup."
    echo "################################################################"
    tput sgr0
fi
