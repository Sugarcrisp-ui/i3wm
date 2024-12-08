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

function enable_cronie() {
    if ! systemctl is-active --quiet cronie.service; then
        log_message "CYAN" "Enabling cronie service..."
        if ! sudo systemctl enable --now cronie.service &>/dev/null; then
            log_message "RED" "Failed to enable or start cronie service"
            exit 1
        fi
    else
        log_message "GREEN" "Cronie service already active"
    fi
}

function get_home_device_uuid() {
    local home_device=$(df --output=source /home | grep -v Filesystem | xargs)
    if [ -z "$home_device" ]; then
        log_message "RED" "Failed to determine home device"
        exit 1
    fi
    local home_uuid=$(sudo blkid "$home_device" -o value -s UUID)
    if [ -z "$home_uuid" ]; then
        log_message "RED" "Failed to get UUID for $home_device"
        exit 1
    fi
    echo "$home_uuid"
}

function update_timeshift_json() {
    local config_path="/etc/timeshift/timeshift.json"
    local backup_device_uuid="$1"

    log_message "CYAN" "Creating Timeshift configuration directory..."
    if ! sudo mkdir -p /etc/timeshift &>/dev/null; then
        log_message "RED" "Failed to create Timeshift configuration directory"
        exit 1
    fi

    log_message "CYAN" "Writing Timeshift configuration..."
    if ! sudo tee "$config_path" > /dev/null <<EOF
    {
        "backup_device_uuid" : "$backup_device_uuid",
        "parent_device_uuid" : "",
        "do_first_run" : "false",
        "btrfs_mode" : "false",
        "include_btrfs_home_for_backup" : "false",
        "include_btrfs_home_for_restore" : "false",
        "stop_cron_emails" : "true",
        "schedule_monthly" : "false",
        "schedule_weekly" : "false",
        "schedule_daily" : "true",
        "schedule_hourly" : "false",
        "schedule_boot" : "false",
        "count_monthly" : "0",
        "count_weekly" : "2",
        "count_daily" : "5",
        "count_hourly" : "0",
        "count_boot" : "0",
        "date_format" : "%Y-%m-%d %H:%M:%S",
        "exclude" : [
            "/home/brett/**",
            "/root/**"
        ],
        "exclude-apps" : []
    }
    EOF
    then
        log_message "RED" "Failed to write Timeshift configuration"
        exit 1
    fi
}

# Main execution
log_message "BLUE" "Starting Timeshift Setup"
enable_cronie

log_message "CYAN" "Getting backup device UUID..."
backup_device_uuid=$(get_home_device_uuid)

update_timeshift_json "$backup_device_uuid"
log_message "GREEN" "Timeshift Configuration Complete! UUID: $backup_device_uuid"