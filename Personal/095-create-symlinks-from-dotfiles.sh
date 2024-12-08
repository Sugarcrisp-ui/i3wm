#!/usr/bin/env bash

# Author: Brett Crisp

declare -A colors=(
    [GREEN]="$(tput setaf 2)"
    [BLUE]="$(tput setaf 4)"
    [CYAN]="$(tput setaf 6)"
    [YELLOW]="$(tput setaf 3)"
    [RED]="$(tput setaf 1)"
    [RESET]="$(tput sgr0)"
)

function log_message() {
    local COLOR=${1}
    shift
    local MSG="${*}"
    echo -e "${colors[$COLOR]}${MSG}${RESET}"
}

# Function to create symlinks
create_symlink() {
    local source="$1"
    local dest="$2"

    if [ -e "$source" ]; then
        if [ ! -e "$dest" ]; then
            ln -s "$source" "$dest"
            log_message "GREEN" "Created: $dest -> $source"
        else
            log_message "YELLOW" "Exists: $dest"
        fi
    else
        log_message "RED" "Missing source: $source"
    fi
}

# Function to replace existing with symlinks
replace_with_symlink() {
    local source="$1"
    local dest="$2"

    if [ -e "$dest" ]; then
        rm -rf "$dest"
        log_message "YELLOW" "Removed existing file at $dest"
    fi
    create_symlink "$source" "$dest"
}

log_message "BLUE" "################################################################"
log_message "BLUE" "                    Setting Up Symlinks"
log_message "BLUE" "################################################################"

# Check if dotfiles directory exists
if [ ! -d "$HOME/dotfiles" ]; then
    log_message "RED" "Error: $HOME/dotfiles directory not found."
    exit 1
fi

# Setup applications symlinks
log_message "CYAN" "Setting up application symlinks..."
applications_source="$HOME/dotfiles/.local/share/applications"
applications_dest="$HOME/.local/share/applications"

mkdir -p "$applications_dest"
log_message "CYAN" "Created directory: $applications_dest"

for app in "$applications_source"/*; do
    [ -f "$app" ] && create_symlink "$app" "$applications_dest/$(basename "$app")"
done

# Setup config symlinks
log_message "CYAN" "Setting up config symlinks..."
config_source="$HOME/dotfiles/.config"
config_dest="$HOME/.config"

for item in "$config_source"/*; do
    [ -e "$item" ] && replace_with_symlink "$item" "$config_dest/$(basename "$item")"
done

# Setup additional symlinks
log_message "CYAN" "Setting up additional symlinks..."

# .bin-personal
create_symlink "$HOME/dotfiles/.bin-personal" "$HOME/.bin-personal"

# .fonts
create_symlink "$HOME/dotfiles/.fonts" "$HOME/.fonts"

# .fehbg
create_symlink "$HOME/dotfiles/.fehbg" "$HOME/.fehbg"

# .grkrc-2.0.mine
create_symlink "$HOME/dotfiles/.gtkrc-2.0.mine" "$HOME/.gtkrc-2.0.mine"

log_message "GREEN" "################################################################"
log_message "GREEN" "                    Symlinks Setup Complete!"
log_message "GREEN" "################################################################"