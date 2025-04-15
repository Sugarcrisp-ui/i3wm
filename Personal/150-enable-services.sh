#!/bin/bash

# Author: Brett Crisp
# Enables system services

# Color definitions
GREEN=$(tput setaf 2)
CYAN=$(tput setaf 6)
RED=$(tput setaf 1)
RESET=$(tput sgr0)

echo "${CYAN}################################################################"
echo "                    Enabling Services"
echo "################################################################${RESET}"

services=(
    "cronie.service"
    "bluetooth.service"
    "sddm.service"
)

for service in "${services[@]}"; do
    if systemctl list-unit-files | grep -q "$service"; then
        echo "${CYAN}Enabling $service...${RESET}"
        sudo systemctl enable "$service" || echo "${RED}Failed to enable $service${RESET}"
        sudo systemctl start "$service" || echo "${RED}Failed to start $service${RESET}"
    else
        echo "${YELLOW}$service not found, skipping${RESET}"
    fi
done

# Configure Bluetooth
if [ -f /etc/bluetooth/main.conf ]; then
    echo "${CYAN}Configuring Bluetooth...${RESET}"
    sudo sed -i 's/#AutoEnable=false/AutoEnable=true/g' /etc/bluetooth/main.conf || echo "${RED}Failed to configure Bluetooth${RESET}"
fi

# Configure PulseAudio
if [ -f /etc/pulse/system.pa ]; then
    echo "${CYAN}Configuring PulseAudio...${RESET}"
    for module in "module-switch-on-connect" "module-bluetooth-policy" "module-bluetooth-discover"; do
        grep -q "load-module $module" /etc/pulse/system.pa || {
            echo "load-module $module" | sudo tee -a /etc/pulse/system.pa || echo "${RED}Failed to configure PulseAudio module $module${RESET}"
        }
    done
fi

# Start PulseAudio user service
systemctl --user enable pulseaudio.service || echo "${RED}Failed to enable PulseAudio user service${RESET}"
systemctl --user start pulseaudio.service || echo "${RED}Failed to start PulseAudio user service${RESET}"

echo "${GREEN}################################################################"
echo "                    Services Enabled!"
echo "################################################################${RESET}"
