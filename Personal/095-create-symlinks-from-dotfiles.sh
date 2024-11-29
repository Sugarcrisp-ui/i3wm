#!/bin/bash

set -e
trap 'echo "An error occurred at line $LINENO. Exiting." >&2; exit 1' ERR

# Function to create symlinks for directories or files
create_symlink() {
    local source="$1"
    local dest="$2"
    
    # Check if destination is not a symlink or exists as a regular file or directory
    if [ -e "$dest" ]; then
        if [ ! -L "$dest" ]; then
            # Remove non-symlink files or directories
            if [ -d "$dest" ]; then
                rm -rf "$dest"
                echo "Removed existing directory: $dest"
            else
                rm -f "$dest"
                echo "Removed existing file: $dest"
            fi
        else
            # Remove symlink
            rm "$dest"
            echo "Removed existing symlink: $dest"
        fi
    fi
    
    # Create the symlink
    ln -s "$source" "$dest" || {
        echo "Failed to create symlink for $dest"
        exit 1
    }
    
    echo "Symlink created: $dest -> $source"
}

# Directories to symlink in home directory
for dir in ".bin-personal" ".fonts" ".bashrc-personal" ".fehbg" ".gtkrc-2.0.mine"; do
    src_path="$HOME/dotfiles/$dir"
    dest_path="$HOME/$dir"
    
    if [ -e "$src_path" ]; then
        create_symlink "$src_path" "$dest_path"
    else
        echo "Warning: Source $src_path does not exist, skipping."
    fi
done

# Handling .local/share/applications
applications_source="$HOME/dotfiles/.local/share/applications"
applications_dest="$HOME/.local/share/applications"

# Ensure .local/share/applications exists in home directory
mkdir -p "$applications_dest"

for app in "$applications_source"/*; do
    if [ -f "$app" ]; then
        app_name=$(basename "$app")
        dest_app="$applications_dest/$app_name"
        
        create_symlink "$app" "$dest_app"
    fi
done

# Handling .config
config_source="$HOME/dotfiles/.config"
config_dest="$HOME/.config"

# Loop through items in the source .config directory
for item in "$config_source"/*; do
    if [ -e "$item" ]; then
        item_name=$(basename "$item")
        dest_item="$config_dest/$item_name"
        
        create_symlink "$item" "$dest_item"
    fi
done

echo "All symlinks have been created."
