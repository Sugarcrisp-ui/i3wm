#!/bin/bash

set -e
trap 'echo "An error occurred at line $LINENO. Exiting." >&2; exit 1' ERR

# Function to create symlinks for directories or files
create_symlink() {
    local source="$1"
    local dest="$2"
    
    if [ -e "$dest" ] && [ ! -L "$dest" ]; then
        # Remove only if it's not already a symlink
        if [ -d "$dest" ]; then
            rm -rf "$dest"
        else
            rm -f "$dest"
        fi
        echo "Removed existing $dest before creating symlink."
    fi
    
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
        
        if [ -e "$dest_app" ] && [ ! -L "$dest_app" ]; then
            rm -f "$dest_app"
            echo "Removed existing $dest_app before creating symlink."
        fi
        
        ln -s "$app" "$dest_app" || {
            echo "Failed to create symlink for $dest_app"
            exit 1
        }
        
        echo "Symlink created: $dest_app -> $app"
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
        
        if [ -e "$dest_item" ] && [ ! -L "$dest_item" ]; then
            if [ -d "$dest_item" ]; then
                rm -rf "$dest_item"
            else
                rm -f "$dest_item"
            fi
            echo "Removed existing $dest_item before creating symlink."
        fi
        
        ln -s "$item" "$dest_item" || {
            echo "Failed to create symlink for $dest_item"
            exit 1
        }
        
        echo "Symlink created: $dest_item -> $item"
    fi
done

echo "All symlinks have been created."
