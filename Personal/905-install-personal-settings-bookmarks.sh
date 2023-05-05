#!/bin/bash

# The set command is used to determine action if error 
# is encountered.  (-e) will stop and exit (+e) will 
# continue with the script.
set -e

# This script installs personal bookmark settings for the user's GTK-3.0 theme.

# Define variables for paths and directories
gtk_config_dir=~/.config/gtk-3.0
settings_dir=~/i3wm/personal-settings/.config/gtk-3.0

# Check that the directories and files exist before copying
if [[ ! -d "$gtk_config_dir" || ! -d "$settings_dir" ]]; then
    echo "Error: one or both directories do not exist."
    exit 1
fi

if [[ ! -f "$settings_dir/bookmarks" || ! -f "$settings_dir/settings.ini" ]]; then
    echo "Error: one or both files do not exist."
    exit 1
fi

# Copy the bookmark settings to the GTK-3.0 config directory
cp "$settings_dir"/* "$gtk_config_dir"/

# Print a message indicating that the settings were installed
echo "Personal bookmark settings installed."

