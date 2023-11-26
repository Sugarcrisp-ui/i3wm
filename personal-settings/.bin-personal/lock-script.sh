#!/bin/bash

# Get the hostname of the machine
HOSTNAME=$(hostnamectl --static)

# Check the hostname and execute the appropriate lock command
if [ "$HOSTNAME" == "brett-ms7d82" ]; then
    betterlockscreen -l
else
    betterlockscreen -s
fi
