#!/bin/bash

set -e
trap 'echo "An error occurred at line $LINENO. Exiting." >&2; exit 1' ERR

# Clone the dotfiles repository if not already present
if [ ! -d "$HOME/dotfiles" ]; then
    echo "Cloning dotfiles repository..."
    git clone https://github.com/Sugarcrisp-ui/dotfiles.git ~/dotfiles
else
    echo "Dotfiles repository already exists, updating..."
    cd ~/dotfiles
    git pull origin main
fi

# Check if the clone/pull was successful
if [ $? -ne 0 ]; then
    echo "Failed to clone or update the dotfiles repository. Please check your internet connection or GitHub access."
    exit 1
fi

echo "Dotfiles cloning completed."
