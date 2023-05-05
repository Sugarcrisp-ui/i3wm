#!/bin/bash

# The set command is used to determine action if error
# is encountered.  (-e) will stop and exit (+e) will
# continue with the script.
set -e

##################################################################################################################
# Settings for a Bluetooth headset.
# After reboot, switch off and on your device to get connected automatically and to the right channel.

# Update main.conf to enable automatic device connection.
echo "Fix 1"
echo "#################"
if ! grep --quiet "AutoEnable=true" /etc/bluetooth/main.conf; then
    sudo sed -i.bak 's/AutoEnable=false/AutoEnable=true/' /etc/bluetooth/main.conf
fi

# Add module-switch-on-connect to default.pa to switch to the Bluetooth device on connect.
echo "Fix 2"
echo "#################"
if ! grep --quiet "module-switch-on-connect" /etc/pulse/default.pa; then
    echo "load-module module-switch-on-connect" | sudo tee -a /etc/pulse/default.pa > /dev/null
fi

# Create a backup file for bluetooth-clear.conf before modifying it.
echo "Fix 3"
echo "#################"
if [ -f /etc/modprobe.d/bluetooth-clear.conf ]; then
    echo "Bluetooth-clear already exists"
else
    echo 'options ath9k btcoex_enable = 1' | sudo tee /etc/modprobe.d/bluetooth-clear.conf > /dev/null
fi

# Notify the user to reboot for the changes to take effect.
echo "################################################################"
echo "#########   Reboot to let the settings take effect   ############"
echo "################################################################"
