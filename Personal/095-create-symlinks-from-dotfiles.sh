#!/bin/bash

set -e
trap 'echo "An error occurred at line $LINENO. Exiting." >&2; exit 1' ERR

# Function to create symlinks for files or directories
create_symlink() {
    local source="$1"
    local dest="$2"

    # Only create symlink if source exists and destination does not already exist
    if [ -e "$source" ]; then
        if [ ! -e "$dest" ]; then
            ln -s "$source" "$dest" || {
                echo "Failed to create symlink for $dest"
                exit 1
            }
            echo "Symlink created: $dest -> $source"
        else
            echo "Skipping $dest, it already exists."
        fi
    else
        echo "Warning: Source $source does not exist, skipping."
    fi
}

# Function to replace matching files or directories with symlinks
replace_with_symlink() {
    local source="$1"
    local dest="$2"

    # If destination exists, remove it before creating the symlink
    if [ -e "$dest" ]; then
        if [ -d "$dest" ]; then
            rm -rf "$dest"
            echo "Removed existing directory: $dest"
        else
            rm -f "$dest"
            echo "Removed existing file: $dest"
        fi
    fi

    # Now create the symlink
    create_symlink "$source" "$dest"
}

# Handling .local/share/applications
applications_source="$HOME/dotfiles/.local/share/applications"
applications_dest="$HOME/.local/share/applications"

# Ensure .local/share/applications exists in home directory
mkdir -p "$applications_dest"

# Loop through the files in the dotfiles applications directory
for app in "$applications_source"/*; do
    if [ -f "$app" ]; then
        app_name=$(basename "$app")
        dest_app="$applications_dest/$app_name"
        
        # Create symlink only if there is no file already in the destination
        create_symlink "$app" "$dest_app"
    fi
done

# Handling .config
config_source="$HOME/dotfiles/.config"
config_dest="$HOME/.config"

# Loop through the items in the source .config directory
for item in "$config_source"/*; do
    if [ -e "$item" ]; then
        item_name=$(basename "$item")
        dest_item="$config_dest/$item_name"
        
        # Replace matching items with symlinks
        replace_with_symlink "$item" "$dest_item"
    fi
done

echo "All symlinks have been created successfully."
