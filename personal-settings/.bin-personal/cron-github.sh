#!/bin/bash

# Define common rsync options
RSYNC_OPTS="-r -t -p -o -g -v --progress -s --delete"

# Directories

rsync $RSYNC_OPTS /var/spool/cron/* /home/brett/Github/i3wm/cron

chown brett:brett /home/brett/Github/i3wm/cron/root



# files


