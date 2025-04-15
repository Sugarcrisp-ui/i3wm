#!/bin/bash

# Author: Brett Crisp
# Clones dotfiles and creates symlinks

# Color definitions
GREEN=$(tput setaf 2)
CYAN=$(tput setaf 6)
RED=$(tput setaf 1)
RESET=$(tput sgr0)

echo "${CYAN}################################################################"
echo "                    Setting Up Dotfiles"
echo "################################################################${RESET}"

# Clone or update dotfiles
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

# Define symlink mappings
declare -A symlinks=(
    ["$HOME/dotfiles/.bashrc"]="$HOME/.bashrc"
    ["$HOME/dotfiles/.bashrc-personal"]="$HOME/.bashrc-personal"
    ["$HOME/dotfiles/.gtkrc-2.0.mine"]="$HOME/.gtkrc-2.0.mine"
    ["$HOME/dotfiles/.fehbg"]="$HOME/.fehbg"
    ["$HOME/dotfiles/.bin-personal"]="$HOME/.bin-personal"
    ["$HOME/dotfiles/.fonts"]="$HOME/.fonts"
    ["$HOME/dotfiles/.config"]="$HOME/.config"
    ["$HOME/dotfiles/.local"]="$HOME/.local"
)

# Create symlinks
for src in "${!symlinks[@]}"; do
    dest="${symlinks[$src]}"
    if [ -e "$src" ]; then
        [ -e "$dest" ] && rm -rf "$dest"
        ln -s "$src" "$dest"
        echo "${GREEN}Linked: $dest -> $src${RESET}"
    else
        echo "${RED}Missing source: $src${RESET}"
    fi
done

echo "${GREEN}################################################################"
echo "                    Dotfiles Setup Complete!"
echo "################################################################${RESET}"
