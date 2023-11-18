#!/bin/bash

# This is a backup of my desktop to my external drive

# Define common rsync options
RSYNC_OPTS="-avz --delete --dirs --perms"
DEST="/run/media/brett/backup"

# Directories

rsync $RSYNC_OPTS /home/brett/.bin-personal/ $DEST/.bin-personal

rsync $RSYNC_OPTS /home/brett/.local/share/Cryptomator/mnt/docs/ $DEST/cryptomator-data

rsync $RSYNC_OPTS /home/brett/Documents/cryptomator/docs/ $DEST/cryptomator-config/docs

rsync $RSYNC_OPTS --exclude={Insync,autostart,google-chrome*} /home/brett/.config/ $DEST/.config

rsync $RSYNC_OPTS /home/brett/.local/share/applications/ $DEST/.local/share/applications

#rsync $RSYNC_OPTS /home/brett/.local/share/ice/ $DEST/.local/share/ice

rsync $RSYNC_OPTS /home/brett/.ssh/ $DEST/.ssh

#rsync $RSYNC_OPTS /home/brett/.var/ $DEST/.var

rsync $RSYNC_OPTS /home/brett/.vnc/ $DEST/.vnc

rsync $RSYNC_OPTS /home/brett/Downloads/ $DEST/Downloads

rsync $RSYNC_OPTS /home/brett/Pictures/ $DEST/Pictures

rsync $RSYNC_OPTS /usr/share/sddm/themes/arcolinux-sugar-candy/ $DEST/usr/share/sddm/themes/arcolinux-sugar-candy



# files

rsync $RSYNC_OPTS /home/brett/.bashrc-personal $DEST/.bashrc-personal

rsync $RSYNC_OPTS /home/brett/.config/variety/variety.conf $DEST/.config/variety/variety.conf
