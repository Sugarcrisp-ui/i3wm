#!/bin/bash

# Identify the home device and UUID
home_device=$(df --output=source /home | grep -v Filesystem | xargs)
home_device_uuid=$(sudo blkid "$home_device" -o value -s UUID)

echo "Home device: $home_device"
echo "Home device UUID: $home_device_uuid"

# Define the path for the timeshift JSON file
timeshift_json="/etc/timeshift/timeshift.json"

# Check if the JSON file exists, and create it if necessary
if [ ! -f "$timeshift_json" ]; then
    echo "$timeshift_json not found. Creating it..."
    sudo mkdir -p /etc/timeshift
    sudo touch "$timeshift_json"
    sudo chmod 644 "$timeshift_json"
    # Add default values to the JSON file
    sudo cat <<EOF > "$timeshift_json"
{
  "backup_device_uuid" : "",
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
    echo "Created $timeshift_json with default values."
else
    echo "$timeshift_json already exists."
fi

# Update the backup_device_uuid with the detected home device UUID
sudo jq --arg uuid "$home_device_uuid" '.backup_device_uuid = $uuid' "$timeshift_json" | sudo tee "$timeshift_json" > /dev/null

echo "Updated backup_device_uuid in $timeshift_json"
