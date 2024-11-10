#!/bin/bash

# Ensure the script uses the right environment
export PATH=$PATH:/usr/bin:/bin

# Check if the project directory exists
if [ -d "/home/brett/i3-auto-layout" ]; then
  # Navigate to the project directory
  cd /home/brett/i3-auto-layout || { echo "Failed to navigate to i3-auto-layout directory"; exit 1; }
  
  # Perform a git pull
  git pull || { echo "Failed to update the git repository"; exit 1; }

  # Update dependencies
  cargo update || { echo "Failed to update dependencies"; exit 1; }

  # Rebuild the project
  cargo build || { echo "Failed to build the project"; exit 1; }
else
  echo "Directory /home/brett/i3-auto-layout does not exist."
  exit 1
fi
