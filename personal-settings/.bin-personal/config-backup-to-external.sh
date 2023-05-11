#!/bin/bash

# This is a backup of my desktop to my external drive

# Define common rsync options
RSYNC_OPTS="-r -t -p -o -g -v --progress --delete"
DESTINATION="/run/media/brett/backup/"

# Directories

rsync $RSYNC_OPTS /home/brett/.bin-personal/ $DESTINATION/.bin-personal

rsync $RSYNC_OPTS --exclude={Insync,autostart,facebookmessenger-nativefier-2f39e1,twitter-nativefier-a629d8,whatsapp-nativefier-d40211} /home/brett/.config/ $DESTINATION/.config

rsync $RSYNC_OPTS /home/brett/.local/share/applications/ $DESTINATION/.local/share/applications

rsync $RSYNC_OPTS /home/brett/.ssh/ $DESTINATION/.ssh

#rsync $RSYNC_OPTS /home/brett/.var/ $DESTINATION/.var

rsync $RSYNC_OPTS /home/brett/.vnc/ $DESTINATION/.vnc

rsync $RSYNC_OPTS /home/brett/Downloads/ $DESTINATION/Downloads

rsync $RSYNC_OPTS /home/brett/Pictures/ $DESTINATION/Pictures



# files

rsync $RSYNC_OPTS /home/brett/.bashrc-personal $DESTINATION/.bashrc-personal

rsync $RSYNC_OPTS /home/brett/.config/variety/variety.conf $DESTINATION/.config/variety/variety.conf
