#!/bin/bash
# The set command is used to determine action if error
# is encountered.  (-e) will stop and exit (+e) will
# continue with the script.
#set -e

##################################################################################################################
# Author  :   Brett Crisp
##################################################################################################################

# Function to extend sudo timeout
extend_sudo_timeout() {
    local timeout=$1
    for i in $(seq 1 $((timeout/15))); do
        sudo -v
    done
}

# Fix keyring issues (if any) using the 'fixkey' alias from Arcolinux
echo
echo "Running fixkey to resolve any GPG key issues..."
sudo fixkey

# Change the number of parallel downloads to 20
echo
echo "Pacman parallel downloads if needed - Arcolinux"
FIND="ParalleDownloads = 8"
REPLACE="ParalleDownloads = 20"
sudo sed -i "s/$FIND/$REPLACE/g" /etc/pacman.conf

echo
echo "Pacman parallel downloads if needed - Arch Linux"
FIND="#ParalleDownloads = 5"
REPLACE="ParalleDownloads = 20"
sudo sed -i "s/$FIND/$REPLACE/g" /etc/pacman.conf

# Update the package lists
sudo pacman -Syyu --noconfirm

# Make executable only the shell scripts in the Personal directory
chmod +x Personal/*.sh

# Change directory to Personal and run each script in order
cd Personal

declare -a scripts=(
  "080-i3wm-install"
  "090-git-clone-dotfiles"
  "092-automount-remote-drive"
  "095-create-symlinks-from-dotfiles"
  "666-remove-software"
# Only use if installing from clean arch  "105-install-arcolinux-software"
  "110-install-core-software"
  "115-warp-terminal-install"
  "120-sound"
  "160-laptop"
  "200-software-AUR-repo"
  "250-software-flatpak"
  "130-bluetooth"
  "260-enable-timeshift"
  "270-enable-hblock"
  "700-installing-fonts"
  "900-install-personal-settings-folders"
# Currently using symlink from dotfiles  "905-install-personal-settings-bookmarks"
#  "930-autostart-applications"
  "940-btrfs-setup"
  "950-fix-pamac-aur"
 )

for script in "${scripts[@]}"
do
  bash "${script}.sh"
done

# Start needed services (the rest were commented out or not applicable)
sudo systemctl enable cronie.service
sudo mkinitcpio -P 

# Notify user that installation is complete
tput setaf 1;
echo "################################################################"
echo "INSTALLATION IS COMPLETE"
echo "ENJOY"
echo "################################################################"
tput sgr0
