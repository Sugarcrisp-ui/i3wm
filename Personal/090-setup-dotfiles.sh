#!/bin/bash

# Author: Brett Crisp
# Clones dotfiles from GitHub and creates symlinks

# Color definitions
GREEN=$(tput setaf 2)
BLUE=$(tput setaf 4)
CYAN=$(tput setaf 6)
YELLOW=$(tput setaf 3)
RED=$(tput setaf 1)
RESET=$(tput sgr0)

# Clone or update dotfiles
echo "${CYAN}################################################################"
echo "                    Cloning Dotfiles"
echo "################################################################${RESET}"

if [ ! -d "$HOME/dotfiles" ]; then
    echo "${CYAN}Cloning dotfiles repository...${RESET}"
    git clone https://github.com/Sugarcrisp-ui/dotfiles.git ~/dotfiles || {
        echo "${RED}Failed to clone dotfiles${RESET}"
        exit 1
    }
else
    echo "${CYAN}Updating existing dotfiles...${RESET}"
    cd ~/dotfiles && git pull origin main || {
        echo "${RED}Failed to update dotfiles${RESET}"
        exit 1
    }
fi

# Function to create symlinks
create_symlink() {
    local source="$1"
    local dest="$2"

    if [ -e "$source" ]; then
        if [ ! -e "$dest" ]; then
            ln -s "$source" "$dest"
            echo "${GREEN}Created: $dest -> $source${RESET}"
        else
            echo "${YELLOW}Exists: $dest${RESET}"
        fi
    else
        echo "${RED}Missing source: $source${RESET}"
    fi
}

# Function to replace existing with symlinks
replace_with_symlink() {
    local source="$1"
    local dest="$2"

    if [ -e "$source" ]; then
        [ -e "$dest" ] && rm -rf "$dest"
        ln -s "$source" "$dest"
        echo "${GREEN}Replaced: $dest -> $source${RESET}"
    else
        echo "${RED}Missing source: $source${RESET}"
    fi
}

# Function to symlink like-for-like without removing other files
symlink_like_for_like() {
    local source_dir="$1"
    local dest_dir="$2"

    mkdir -p "$dest_dir"

    for item in "$source_dir"/*; do
        if [ -e "$item" ]; then
            local dest="$dest_dir/$(basename "$item")"
            if [ -e "$dest" ]; then
                rm -rf "$dest"
                echo "${YELLOW}Removed existing: $dest${RESET}"
            fi
            ln -s "$item" "$dest"
            echo "${GREEN}Linked: $dest -> $item${RESET}"
        fi
    done
}

echo "${BLUE}################################################################"
echo "                    Setting Up Symlinks"
echo "################################################################${RESET}"

# Setup applications symlinks
echo "${CYAN}Setting up application symlinks...${RESET}"
applications_source="$HOME/dotfiles/.local/share/applications"
applications_dest="$HOME/.local/share/applications"

mkdir -p "$applications_dest"

for app in "$applications_source"/*; do
    [ -f "$app" ] && create_symlink "$app" "$applications_dest/$(basename "$app")"
done

# Setup .config symlinks (like-for-like)
echo "${CYAN}Setting up .config symlinks...${RESET}"
config_source="$HOME/dotfiles/.config"
config_dest="$HOME/.config"

symlink_like_for_like "$config_source" "$config_dest"

# Setup .local symlinks (like-for-like)
echo "${CYAN}Setting up .local symlinks...${RESET}"
local_source="$HOME/dotfiles/.local"
local_dest="$HOME/.local"

symlink_like_for_like "$local_source" "$local_dest"

# Setup additional symlinks
echo "${CYAN}Setting up additional symlinks...${RESET}"

## FILES
replace_with_symlink "$HOME/dotfiles/.bashrc" "$HOME/.bashrc"
replace_with_symlink "$HOME/dotfiles/.bashrc-personal" "$HOME/.bashrc-personal"
replace_with_symlink "$HOME/dotfiles/.gtkrc-2.0.mine" "$HOME/.gtkrc-2.0.mine"
replace_with_symlink "$HOME/dotfiles/.fehbg" "$HOME/.fehbg"

## DIRECTORIES
replace_with_symlink "$HOME/dotfiles/.bin-personal" "$HOME/.bin-personal"
replace_with_symlink "$HOME/dotfiles/.fonts" "$HOME/.fonts"

echo "${GREEN}################################################################"
echo "                    Dotfiles Setup Complete!"
echo "################################################################${RESET}"
