#!/bin/bash

# The set command is used to determine action if error
# is encountered.  (-e) will stop and exit (+e) will
# continue with the script.
set -e

###############################################################################
#
#   DECLARATION OF FUNCTIONS
#
###############################################################################

# Function to install packages
func_install() {
    # Check if package is already installed
    if pacman -Qi "$1" &> /dev/null; then
        printf "\e[32m###############################################################################\n"
        printf "################## The package '%s' is already installed\n" "$1"
        printf "###############################################################################\n\n"
    else
        printf "\e[33m###############################################################################\n"
        printf "##################  Installing package '%s'\n" "$1"
        printf "###############################################################################\n\n"
        # Install the package
        sudo pacman -S --noconfirm --needed "$1" 
    fi
}

###############################################################################
printf "Installation of laptop software\n"
###############################################################################

# List of packages to install
list=(
    tlp
)

count=0

# Install each package in the list
for name in "${list[@]}"; do
    count=$((count+1))
    printf "\e[33mInstalling package nr. %s '%s'\n\e[0m" "$count" "$name"
    # Install the package using the func_install function
    set +e
    func_install "$name"
    set -e
done

###############################################################################
printf "\e[35m################################################################\n"
printf "Enabling services\n"
printf "################################################################\n\n\e[0m"

# Enable TLP service
sudo systemctl enable tlp.service

printf "\e[32m################################################################\n"
printf "Software has been installed\n"
printf "################################################################\n\n\e[0m"
