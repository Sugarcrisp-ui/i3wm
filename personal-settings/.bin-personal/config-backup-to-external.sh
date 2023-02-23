#!/bin/bash

# This is a backup of my desktop to my external drive

# Define common rsync options
RSYNC_OPTS="-r -t -p -o -g -v --progress -s --delete"
DESTINATION="/run/media/brett/7836d530-f67e-4d6b-a1ee-65e980d6dd45/desktop"

# Directories

rsync $RSYNC_OPTS /home/brett/.bin-personal/ $DESTINATION/.bin-personal

rsync $RSYNC_OPTS --exclude 'Insync' /home/brett/.config/ $DESTINATION/.config

rsync $RSYNC_OPTS /home/brett/.local/share/applications/ $DESTINATION/.local/share/applications

rsync $RSYNC_OPTS /home/brett/.local/share/ice/ $DESTINATION/.local/share/ice

rsync $RSYNC_OPTS /home/brett/.ssh/ $DESTINATION/.ssh

#rsync $RSYNC_OPTS /home/brett/.var/ $DESTINATION/.var

rsync $RSYNC_OPTS /home/brett/.vnc/ $DESTINATION/.vnc

rsync $RSYNC_OPTS /home/brett/Downloads/ $DESTINATION/Downloads

rsync $RSYNC_OPTS /home/brett/Pictures/ $DESTINATION/Pictures

rsync $RSYNC_OPTS /home/brett/Webapps/ $DESTINATION/Webapps



# files

rsync $RSYNC_OPTS /home/brett/.bashrc-personal $DESTINATION/.bashrc-personal

rsync $RSYNC_OPTS /home/brett/.config/variety/variety.conf $DESTINATION/.config/variety/variety.conf
