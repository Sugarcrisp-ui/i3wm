#!/bin/bash

# Author: Brett Crisp
# Configures personal settings, Polybar, hblock, Timeshift

# Color definitions
GREEN=$(tput setaf 2)
CYAN=$(tput setaf 6)
YELLOW=$(tput setaf 3)
RESET=$(tput sgr0)

echo "${CYAN}################################################################"
echo "                    Configuring Personal Settings"
echo "################################################################${RESET}"

# Create personal directories
for dir in Appimages Shared; do
    echo "${CYAN}Creating $HOME/$dir...${RESET}"
    mkdir -p "$HOME/$dir"
done

# Polybar
if [ -f "$HOME/.config/polybar/launch.sh" ]; then
    echo "${CYAN}Configuring Polybar...${RESET}"
    chmod +x "$HOME/.config/polybar/launch.sh"
fi

# hblock
if command -v hblock &>/dev/null; then
    echo "${CYAN}Running hblock...${RESET}"
    sudo hblock || echo "${YELLOW}Warning: hblock failed${RESET}"
fi

# Timeshift
if command -v timeshift &>/dev/null; then
    echo "${CYAN}Configuring Timeshift...${RESET}"
    home_device=$(df --output=source /home | grep -v Filesystem | xargs)
    home_uuid=$(sudo blkid "$home_device" -o value -s UUID 2>/dev/null)
    if [ -n "$home_uuid" ]; then
        sudo mkdir -p /etc/timeshift
        sudo tee /etc/timeshift/timeshift.json > /dev/null <<EOF
{
    "backup_device_uuid" : "$home_uuid",
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
    fi
fi

# rc.local
RC_LOCAL=$(ls -t /run/media/brett/backup/system-files/etc/rc.local.* 2>/dev/null | head -n 1)
if [ -f "$RC_LOCAL" ]; then
    echo "${CYAN}Configuring rc.local from $RC_LOCAL...${RESET}"
    [ -f /etc/rc.local ] && sudo cp /etc/rc.local "/etc/rc.local.bak"
    sudo cp "$RC_LOCAL" /etc/rc.local
    sudo chmod 755 /etc/rc.local
else
    echo "${YELLOW}No rc.local backup found, skipping${RESET}"
fi

echo "${GREEN}################################################################"
echo "                    Personal Settings Configured!"
echo "################################################################${RESET}"
