#!/bin/bash

set -e
trap 'echo "An error occurred at line $LINENO. Exiting." >&2; exit 1' ERR

source_dir="/run/media/brett/backup"
dest_dir="$HOME"

directories_to_symlink=(
    ".bin-personal"
    ".config"
    ".fonts"
    ".local"
    ".ssh"
    "Documents"
    "Downloads"
    "Music"
    "Pictures"
    "Trading"
    "usr"
    "Videos"
    ".bashrc-personal"
    ".fehbg"
)

# Function to log with color
log_with_color() {
    tput setaf 11; echo "################################################################"; tput sgr0
    tput setaf 11; echo "$1"; tput sgr0
    tput setaf 11; echo "################################################################"; tput sgr0
}

# Function to handle special directories like .config
handle_special_dir() {
    local src="$1"
    local dest="$2"
    
    log_with_color "Handling special directory $dest"

    # Ensure destination directory exists
    if [ ! -d "$dest" ]; then
        mkdir -p "$dest"
    fi

    # Loop through each item in the source directory
    for item in "$src"/*; do
        if [ -e "$item" ]; then
            item_name=$(basename "$item")
            dest_item="$dest/$item_name"

            if [ -e "$dest_item" ]; then
                if [ -L "$dest_item" ]; then
                    # If symlink, check if it points to correct source
                    if [ "$(readlink "$dest_item")" != "$item" ]; then
                        rm "$dest_item"
                        ln -s "$item" "$dest_item" || { log_with_color "Failed to update symlink for $item_name in $dest"; exit 1; }
                    fi
                elif [ -d "$dest_item" ]; then
                    # If it's a directory, replace with symlink
                    rm -rf "$dest_item"
                    ln -s "$item" "$dest_item" || { log_with_color "Failed to create symlink for directory $item_name in $dest"; exit 1; }
                else
                    # If it's a file, remove it and symlink
                    rm "$dest_item"
                    ln -s "$item" "$dest_item" || { log_with_color "Failed to create symlink for $item_name in $dest"; exit 1; }
                fi
            else
                # If nothing exists, create symlink
                ln -s "$item" "$dest_item" || { log_with_color "Failed to create new symlink for $item_name in $dest"; exit 1; }
            fi
            
            log_with_color "Symlink for $item_name in $dest created or updated: $dest_item -> $item"
        fi
    done
}

# Function to handle .local/share/applications
handle_local_applications() {
    local src="$1"
    local dest="$2"
    
    log_with_color "Handling .local/share/applications"

    # Ensure destination directory exists
    if [ ! -d "$dest" ]; then
        mkdir -p "$dest"
    fi

    # Loop through each .desktop file in the source directory
    for item in "$src"/*.desktop; do
        if [ -e "$item" ]; then
            item_name=$(basename "$item")
            dest_item="$dest/$item_name"

            if [ -e "$dest_item" ]; then
                # Replace existing file with symlink
                rm "$dest_item"
                ln -s "$item" "$dest_item" || { log_with_color "Failed to create symlink for $item_name in $dest"; exit 1; }
            else
                # If nothing exists, create symlink
                ln -s "$item" "$dest_item" || { log_with_color "Failed to create new symlink for $item_name in $dest"; exit 1; }
            fi
            
            log_with_color "Symlink for $item_name in $dest created or updated: $dest_item -> $item"
        fi
    done
}

# Check if source directory exists
if ! [ -d "$source_dir" ]; then
    log_with_color "Error: Source directory $source_dir does not exist or is not accessible."
    exit 1
fi

for dir in "${directories_to_symlink[@]}"; do
    src_path="${source_dir}/${dir}"
    dest_path="${dest_dir}/${dir}"
    
    if ! [ -e "$src_path" ]; then
        log_with_color "Warning: Source $src_path does not exist, skipping."
        continue
    fi

    case "$dir" in
        ".config")
            handle_special_dir "$src_path" "$dest_path"
            ;;
        ".local")
            # Only handle .local/share/applications
            src_apps="${src_path}/share/applications"
            dest_apps="${dest_path}/share/applications"
            if [ -d "$src_apps" ]; then
                handle_local_applications "$src_apps" "$dest_apps"
            else
                log_with_color "Warning: .local/share/applications does not exist in source, skipping."
            fi
            ;;
        *)
            # Handle other directories as before
            if [ -e "$dest_path" ]; then
                if [ -L "$dest_path" ]; then
                    # If it's a symlink, check if it's pointing to the correct location
                    if [ "$(readlink "$dest_path")" != "$src_path" ]; then
                        log_with_color "Updating symlink for $dir"
                        rm "$dest_path"
                        ln -s "$src_path" "$dest_path" || { log_with_color "Failed to update symlink for $dir"; exit 1; }
                    else
                        log_with_color "Symlink for $dir already points to correct source."
                    fi
                elif [ -d "$dest_path" ]; then
                    # If it's an existing directory, replace with symlink
                    log_with_color "Replacing existing directory $dir with symlink."
                    rm -rf "$dest_path"
                    ln -s "$src_path" "$dest_path" || { log_with_color "Failed to create symlink for $dir"; exit 1; }
                else
                    # If it's a file, remove and create symlink
                    log_with_color "Removing existing file $dir and creating symlink."
                    rm "$dest_path"
                    ln -s "$src_path" "$dest_path" || { log_with_color "Failed to create symlink for $dir"; exit 1; }
                fi
            else
                # If nothing exists at the destination, create the symlink
                log_with_color "Creating new symlink for $dir"
                ln -s "$src_path" "$dest_path" || { log_with_color "Failed to create new symlink for $dir"; exit 1; }
            fi
            ;;
    esac
done

log_with_color "All symlinks have been processed."