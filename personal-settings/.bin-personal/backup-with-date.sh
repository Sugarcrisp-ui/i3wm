#!/bin/bash
# This script creates a backup of a file with the current date and time in its name

# Check if a filename is provided as an argument
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 filename"
    exit 1
fi

# Get the filename from the argument
filename=$1

# Create a backup of the file
cp $filename $filename.$(date +%Y%m%d_%H%M%S)
