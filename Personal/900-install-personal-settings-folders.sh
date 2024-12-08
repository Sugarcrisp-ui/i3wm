#!/usr/bin/env bash

# Author: Brett Crisp

declare -A colors=(
    [GREEN]="$(tput setaf 2)"
    [BLUE]="$(tput setaf 4)"
    [CYAN]="$(tput setaf 6)"
    [YELLOW]="$(tput setaf 3)"
    [RESET]="$(tput sgr0)"
)

function log_message() {
    local COLOR=${1}
    shift
    local MSG="${*}"
    echo -e "${colors[$COLOR]}################################################################${RESET}"
    echo -e "${colors[$COLOR]}${MSG}${RESET}"
    echo -e "${colors[$COLOR]}################################################################${RESET}"
}

function create_directory() {
    local dir="$1"
    log_message "CYAN" "Creating directory: $dir"
    mkdir -p "$dir" || {
        log_message "RED" "Failed to create directory: $dir"
        return 1
    }
    return 0
}

function setup_ssh() {
    log_message "CYAN" "Checking SSH Configuration"
    local SOURCE_SSH="/run/media/brett/backup/.ssh"
    local DEST_SSH="$HOME/.ssh"
    
    if [ ! -d "$DEST_SSH" ]; then
        if ! mkdir -p "$DEST_SSH" || ! chmod 700 "$DEST_SSH"; then
            log_message "RED" "Failed to create or set permissions for $DEST_SSH"
            return 1
        fi
    fi
    
    if [ -d "$SOURCE_SSH" ]; then
        log_message "CYAN" "External drive found - syncing SSH files"
        if ! rsync -avz --delete "$SOURCE_SSH/" "$DEST_SSH/" || \
           ! chmod 700 "$DEST_SSH" || \
           ! chmod 600 "$DEST_SSH"/*; then
            log_message "RED" "Failed to sync or apply permissions to SSH files"
            return 1
        fi
    else
        log_message "YELLOW" "External drive not found - skipping SSH sync"
    fi
    return 0
}

function setup_rc_local() {
    log_message "BLUE" "Setting Up rc.local"
    if [ -f "/etc/rc.local" ]; then
        sudo cp /etc/rc.local "/etc/rc.local.$(date +"%Y%m%d%H%M%S").bak" || {
            log_message "RED" "Failed to backup rc.local"
            return 1
        }
    fi

    local SOURCE_RC_LOCAL="$HOME/i3wm/personal-settings/etc/rc.local"
    if [ -f "$SOURCE_RC_LOCAL" ]; then
        log_message "CYAN" "Copying and configuring rc.local"
        if ! sudo rsync -avz --delete "$SOURCE_RC_LOCAL" /etc/ || \
           ! sudo chown root:root /etc/rc.local || \
           ! sudo chmod 755 /etc/rc.local; then
            log_message "RED" "Failed to setup rc.local"
            return 1
        fi
    fi
    return 0
}

function setup_crontabs() {
    log_message "CYAN" "Checking Crontab Configuration"
    local CRON_SOURCE_DIR="/run/media/brett/backup/cron"
    local CRON_DEST_DIR="/var/spool/cron"

    if [ -d "$CRON_SOURCE_DIR" ]; then
        log_message "CYAN" "External drive found - configuring crontabs"
        sudo mkdir -p "$CRON_DEST_DIR" || return 1
        
        # User cron
        if [ -f "$CRON_SOURCE_DIR/brett" ]; then
            log_message "CYAN" "Setting up user crontab"
            if ! sudo rsync -avz --delete "$CRON_SOURCE_DIR/brett" "$CRON_DEST_DIR/brett" || \
               ! sudo chown brett:brett "$CRON_DEST_DIR/brett" || \
               ! sudo chmod 600 "$CRON_DEST_DIR/brett"; then
                log_message "RED" "Failed to setup user crontab"
                return 1
            fi
        fi
        
        # Root cron
        if [ -f "$CRON_SOURCE_DIR/root" ]; then
            log_message "CYAN" "Setting up root crontab"
            if ! sudo rsync -avz --delete "$CRON_SOURCE_DIR/root" "$CRON_DEST_DIR/root" || \
               ! sudo chown root:root "$CRON_DEST_DIR/root" || \
               ! sudo chmod 600 "$CRON_DEST_DIR/root"; then
                log_message "RED" "Failed to setup root crontab"
                return 1
            fi
        fi
    else
        log_message "YELLOW" "External drive not found - skipping crontab setup"
    fi
    return 0
}

function setup_polybar() {
    log_message "BLUE" "Setting Up Polybar"
    local POLYBAR_LAUNCH="$HOME/.config/polybar/launch.sh"
    if [ -f "$POLYBAR_LAUNCH" ]; then
        if ! chmod +x "$POLYBAR_LAUNCH"; then
            log_message "RED" "Failed to make Polybar launch script executable"
            return 1
        fi
    fi
    return 0
}

# Main execution
log_message "BLUE" "Creating Personal Folders"
for dir in "Appimages" "Shared"; do
    create_directory "$HOME/$dir" || exit 1
done

setup_ssh || exit 1
setup_rc_local || exit 1
setup_crontabs || exit 1
setup_polybar || exit 1

log_message "GREEN" "                    Personal Settings Setup Complete!"