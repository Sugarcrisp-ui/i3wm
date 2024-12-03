#!/bin/bash

# Color definitions
GREEN=$(tput setaf 2)
BLUE=$(tput setaf 4)
CYAN=$(tput setaf 6)
YELLOW=$(tput setaf 3)
RESET=$(tput sgr0)

function log_message() {
    echo "${BLUE}################################################################"
    echo "$1"
    echo "################################################################${RESET}"
}

function enable_cronie() {
    if ! systemctl is-active --quiet cronie.service; then
        echo "${CYAN}Enabling cronie service...${RESET}"
        sudo systemctl enable --now cronie.service
    else
        echo "${GREEN}Cronie service already active${RESET}"
    fi
}

function get_home_device_uuid() {
    local home_device=$(df --output=source /home | grep -v Filesystem | xargs)
    local home_uuid=$(sudo blkid "$home_device" -o value -s UUID)
    echo "$home_uuid"
}

function update_timeshift_json() {
    local config_path="/etc/timeshift/timeshift.json"
    local backup_device_uuid="$1"

    echo "${CYAN}Creating Timeshift configuration directory...${RESET}"
    sudo mkdir -p /etc/timeshift

    echo "${CYAN}Writing Timeshift configuration...${RESET}"
    sudo tee "$config_path" > /dev/null <<EOF
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
}

# Main execution
log_message "Starting Timeshift Setup"
enable_cronie

echo "${CYAN}Getting backup device UUID...${RESET}"
backup_device_uuid=$(get_home_device_uuid)

update_timeshift_json "$backup_device_uuid"
log_message "Timeshift Configuration Complete! UUID: $backup_device_uuid"