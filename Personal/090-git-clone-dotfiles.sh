#!/usr/bin/env bash

# Author: Brett Crisp
# Enhanced script for setting up dotfiles with error handling and configurability.

declare -A colors=(
    [GREEN]="$(tput setaf 2)"
    [BLUE]="$(tput setaf 4)"
    [CYAN]="$(tput setaf 6)"
    [RED]="$(tput setaf 1)"
    [RESET]="$(tput sgr0)"
)

function log_message() {
    local COLOR=${1}
    shift
    local MSG="${*}"
    echo -e "${colors[$COLOR]}${MSG}${RESET}"
}

# Repository and destination
REPO_URL=${DOTFILES_REPO_URL:-"https://github.com/Sugarcrisp-ui/dotfiles.git"}
DEST_DIR="$HOME/dotfiles"

# Print header
log_message "BLUE" "################################################################"
log_message "BLUE" "                    Setting Up Dotfiles"
log_message "BLUE" "################################################################"

# Ensure git is installed
if ! command -v git &> /dev/null; then
    log_message "RED" "Error: git is not installed. Please install git and try again."
    exit 1
fi

# Clone or update dotfiles repository
if [ ! -d "$DEST_DIR" ]; then
    log_message "CYAN" "Cloning dotfiles repository into $DEST_DIR..."
    if ! git clone "$REPO_URL" "$DEST_DIR" 2>&1; then
        log_message "RED" "Error: Failed to clone repository from $REPO_URL - $(git clone "$REPO_URL" "$DEST_DIR" 2>&1)"
        exit 1
    fi
else
    log_message "CYAN" "Updating existing dotfiles in $DEST_DIR..."
    if ! cd "$DEST_DIR" || ! git pull origin main 2>&1; then
        log_message "RED" "Error: Failed to update repository in $DEST_DIR - $(cd "$DEST_DIR" && git pull origin main 2>&1)"
        exit 1
    fi
fi

# Success message
log_message "GREEN" "################################################################"
log_message "GREEN" "                    Dotfiles Setup Complete!"
log_message "GREEN" "################################################################"