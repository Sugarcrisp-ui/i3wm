#!/bin/bash

# Color definitions
GREEN=$(tput setaf 2)
BLUE=$(tput setaf 4)
CYAN=$(tput setaf 6)
RED=$(tput setaf 1)
RESET=$(tput sgr0)

# Define paths
gtk_config_dir=~/.config/gtk-3.0
settings_dir=~/i3wm/personal-settings/.config/gtk-3.0

echo "${BLUE}################################################################"
echo "                    Installing GTK Bookmarks"
echo "################################################################${RESET}"

# Verify directories and files
if [[ ! -d "$gtk_config_dir" || ! -d "$settings_dir" ]]; then
    echo "${RED}Required directories not found${RESET}"
    exit 1
fi

if [[ ! -f "$settings_dir/bookmarks" || ! -f "$settings_dir/settings.ini" ]]; then
    echo "${RED}Required files not found${RESET}"
    exit 1
fi

# Copy settings
echo "${CYAN}Copying GTK settings...${RESET}"
cp "$settings_dir"/* "$gtk_config_dir"/

echo "${GREEN}################################################################"
echo "                    GTK Bookmarks Installed Successfully!"
echo "################################################################${RESET}"