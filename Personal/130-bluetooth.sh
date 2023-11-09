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

# Install a package if it is not already installed
func_install() {
    if pacman -Qi $1 &> /dev/null; then
        tput setaf 2
        echo "###############################################################################"
        echo "################## The package "$1" is already installed"
        echo "###############################################################################"
        echo
        tput sgr0
    else
        tput setaf 3
        echo "###############################################################################"
        echo "##################  Installing package "  $1
        echo "###############################################################################"
        echo
        tput sgr0
        sudo pacman -S --noconfirm --needed $1 
    fi
}

###############################################################################
# Install Bluetooth software
###############################################################################

list=(
    #pulseaudio-bluetooth
    bluez
    bluez-libs
    bluez-utils
)

count=0

for name in "${list[@]}" ; do
    count=$[count+1]
    tput setaf 3;echo "Installing package nr.  "$count " " $name;tput sgr0;
    func_install $name
done

###############################################################################
# Enable Bluetooth services
###############################################################################

tput setaf 5;echo "################################################################"
echo "Enabling services"
echo "################################################################"
echo;tput sgr0

# Only enable Bluetooth if it is not already enabled
if ! systemctl is-enabled bluetooth.service &> /dev/null; then
    sudo systemctl enable bluetooth.service
fi

# Only start Bluetooth if it is not already running
if ! systemctl is-active bluetooth.service &> /dev/null; then
    sudo systemctl start bluetooth.service
fi

# Only change the AutoEnable option if it is not already set
if ! grep -q "^AutoEnable=true" /etc/bluetooth/main.conf; then
    sudo sed -i 's/'#AutoEnable=false'/'AutoEnable=true'/g' /etc/bluetooth/main.conf
fi

tput setaf 11;
echo "################################################################"
echo "Bluetooth software has been installed and enabled"
echo "################################################################"
echo;tput sgr0
