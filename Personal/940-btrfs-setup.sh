#!/bin/bash

# The set command is used to determine action if error
# is encountered.  (-e) will stop and exit (+e) will
# continue with the script.
set -e

##################################################################################################################

# Check if the disk is formatted as BTRFS
if 	lsblk -f | grep btrfs > /dev/null 2>&1 ; then
	echo "You are using BTRFS. Installing the software ..."

	# Install necessary packages
	sudo pacman -S --needed --noconfirm timeshift
	sudo pacman -S --needed --noconfirm grub-btrfs
	sudo pacman -S --needed --noconfirm timeshift-autosnap
	#sudo systemctl enable grub-btrfs.path

else
	echo "Your harddisk/ssd/nvme is not formatted as BTRFS."
	echo "Packages will not be installed"
fi

echo "################################################################"
echo "#########   Packages installed - Reboot now     ################"
echo "################################################################"
