#!/usr/bin/env bash

# Author: Brett Crisp

declare -A colors=(
    [GREEN]="$(tput setaf 2)"
    [BLUE]="$(tput setaf 4)"
    [CYAN]="$(tput setaf 6)"
    [RED]="$(tput setaf 1)"
    [RESET]="$(tput sgr0)"
)

function log_message() {
    local COLOR=${1}
    shift
    local MSG="${*}"
    echo -e "${colors[$COLOR]}################################################################${RESET}"
    echo -e "${colors[$COLOR]}${MSG}${RESET}"
    echo -e "${colors[$COLOR]}################################################################${RESET}"
}

# Define paths
gtk_config_dir=~/.config/gtk-3.0
settings_dir=~/i3wm/personal-settings/.config/gtk-3.0

log_message "BLUE" "                    Installing GTK Bookmarks"

# Verify directories and files
for dir in "$gtk_config_dir" "$settings_dir"; do
    if [[ ! -d "$dir" ]]; then
        log_message "RED" "Directory not found: $dir"
        exit 1
    fi
done

for file in "$settings_dir/bookmarks" "$settings_dir/settings.ini"; do
    if [[ ! -f "$file" ]]; then
        log_message "RED" "File not found: $file"
        exit 1
    fi
done

# Copy settings
log_message "CYAN" "Copying GTK settings..."
if ! cp "$settings_dir"/* "$gtk_config_dir"/; then
    log_message "RED" "Failed to copy GTK settings"
    exit 1
fi

log_message "GREEN" "                    GTK Bookmarks Installed Successfully!"