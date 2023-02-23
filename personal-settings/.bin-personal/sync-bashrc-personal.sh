#!/bin/bash

# this provides 2-way sync of my .bashrc-personal file via insync and my Google Drive
# I use crontab to sync every 10s

# Define common rsync options
RSYNC_OPTS="-avuP"

rsync $RSYNC_OPTS ~/.bashrc-personal /home/brett/bashrc-personal/.bashrc-personal
rsync $RSYNC_OPTS /home/brett/bashrc-personal/.bashrc-personal ~/.bashrc-personal
