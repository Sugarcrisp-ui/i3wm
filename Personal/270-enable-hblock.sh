#!/bin/bash

# Color definitions
GREEN=$(tput setaf 2)
BLUE=$(tput setaf 4)
CYAN=$(tput setaf 6)
RESET=$(tput sgr0)

function log_message() {
    echo "${BLUE}################################################################"
    echo "$1"
    echo "################################################################${RESET}"
}

# Update hosts file
log_message "Starting Host File Update"
echo "${CYAN}Running hblock to update system hosts file...${RESET}"

sudo hblock && echo "${GREEN}Host file update completed successfully!${RESET}"

log_message "Host File Protection Enabled"