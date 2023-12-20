#!/bin/bash

# Define common rsync options
RSYNC_OPTS="-r -t -p -o -g -v --progress -s --delete"

# Directories

for dir in \
    cron
do
    sudo rsync $RSYNC_OPTS /var/spool/$dir/* /home/brett/Github/i3wm/personal-settings/var/spool/cron/
    sudo chown -R brett:brett /home/brett/Github/i3wm/personal-settings/var/spool/cron/
done

# Error handling
if [ $? -ne 0 ]; then
    echo "An error occurred during the backup process."
    exit 1
fi

echo "Backup completed successfully."
