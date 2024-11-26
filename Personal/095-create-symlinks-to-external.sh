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

if ! [ -d "$source_dir" ]; then
    echo "Error: Source directory $source_dir does not exist or is not mounted."
    exit 1
fi

for dir in "${directories_to_symlink[@]}"; do
    src_path="${source_dir}/${dir}"
    dest_path="${dest_dir}/${dir}"
    
    if ! [ -e "$src_path" ]; then
        echo "Warning: Source $src_path does not exist, skipping."
        continue
    fi
    
    if [[ "$dir" != .* ]]; then
        mkdir -p "$(dirname "$dest_path")"
    fi
    
    if [ -e "$dest_path" ] && [ ! -L "$dest_path" ] || [ -L "$dest_path" ] && ! [ -e "$dest_path" ]; then
        rm -rf "$dest_path"
    fi
    
    ln -s "$src_path" "$dest_path" || { echo "Failed to create symlink for $dir"; exit 1; }
    
    echo "Symlink created: $dest_path -> $src_path"
done

echo "All symlinks have been created."