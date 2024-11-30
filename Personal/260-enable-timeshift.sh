#!/bin/bash

# Set up error handling
set -e
trap 'echo "An error occurred at line $LINENO. Exiting." >&2; exit 1' ERR

# Function for colored logging
log_with_color() {
    tput setaf 11; echo "################################################################"; tput sgr0
    tput setaf 11; echo "$1"; tput sgr0
    tput setaf 11; echo "################################################################"; tput sgr0
}

# Function to extend sudo timeout
extend_sudo_timeout() {
    local timeout=$1
    for i in $(seq 1 $((timeout / 15))); do
        sudo -v
        sleep 10
    done
}

# Extend sudo timeout for the script duration (60 minutes)
extend_sudo_timeout 3600 &

# Check if cronie is enabled and start it if not
enable_cronie() {
    if ! systemctl is-active --quiet cronie.service; then
        log_with_color "Enabling and starting cronie.service"
        sudo systemctl enable --now cronie.service
    else
        log_with_color "Cronie service is already running"
    fi
}

# Identify the home device and UUID
get_home_device_uuid() {
    local home_device
    local home_uuid

    home_device=$(df --output=source /home | grep -v Filesystem | xargs)
    home_uuid=$(sudo blkid "$home_device" -o value -s UUID)

    if [ -z "$home_uuid" ]; then
        log_with_color "Could not determine UUID for /home. Exiting."
        exit 1
    fi

    echo "$home_uuid"
}

# Write or update Timeshift configuration
update_timeshift_json() {
    local config_path="/etc/timeshift/timeshift.json"
    local backup_device_uuid="$1"

    log_with_color "Updating Timeshift configuration at $config_path"

    sudo mkdir -p /etc/timeshift

    # Write or replace the JSON content
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
  "count_monthly" : "2",
  "count_weekly" : "3",
  "count_daily" : "5",
  "count_hourly" : "6",
  "count_boot" : "5",
  "date_format" : "%Y-%m-%d %H:%M:%S",
  "exclude" : [
    "/home/brett/**",
    "/root/**"
  ],
  "exclude-apps" : []
}
EOF
    log_with_color "Timeshift configuration updated successfully."
}

# Main execution flow
log_with_color "Starting Timeshift setup script"
enable_cronie
backup_device_uuid=$(get_home_device_uuid)
update_timeshift_json "$backup_device_uuid"

log_with_color "Setup complete. Timeshift is configured with backup_device_uuid: $backup_device_uuid"
