#!/bin/bash

# Ensure the script uses the right environment
export PATH=$PATH:/usr/bin:/bin

# Navigate to the i3lock-color directory
cd /home/brett/i3lock-color

# Fetch all branches to update local information on remote branches
git fetch --all

# Check if 'main' or 'master' exist and check out the correct branch
if git show-ref --verify --quiet refs/remotes/origin/main; then
    git checkout main
    git pull origin main
elif git show-ref --verify --quiet refs/remotes/origin/master; then
    git checkout master
    git pull origin master
else
    echo "Error: Neither 'main' nor 'master' branches exist on the remote repository."
    exit 1
fi

# Run the build/install script
./install-i3lock-color.sh
