#!/bin/bash

# Color definitions
GREEN=$(tput setaf 2)
BLUE=$(tput setaf 4)
CYAN=$(tput setaf 6)
YELLOW=$(tput setaf 3)
RED=$(tput setaf 1)
RESET=$(tput sgr0)

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

    [ -e "$dest" ] && rm -rf "$dest"
    create_symlink "$source" "$dest"
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

# Setup config symlinks
echo "${CYAN}Setting up config symlinks...${RESET}"
config_source="$HOME/dotfiles/.config"
config_dest="$HOME/.config"

for item in "$config_source"/*; do
    [ -e "$item" ] && replace_with_symlink "$item" "$config_dest/$(basename "$item")"
done

# Setup additional symlinks
echo "${CYAN}Setting up additional symlinks...${RESET}"

# .bin-personal
create_symlink "$HOME/dotfiles/.bin-personal" "$HOME/.bin-personal"

# .fonts
create_symlink "$HOME/dotfiles/.fonts" "$HOME/.fonts"

# .fehbg
create_symlink "$HOME/dotfiles/.fehbg" "$HOME/.fehbg"

# .grkrc-2.0.mine
create_symlink "$HOME/dotfiles/.gtkrc-2.0.mine" "$HOME/.gtkrc-2.0.mine"

echo "${GREEN}################################################################"
echo "                    Symlinks Setup Complete!"
echo "################################################################${RESET}"