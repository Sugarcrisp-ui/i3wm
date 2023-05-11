#!/bin/bash

# Define common rsync options
RSYNC_OPTS="-avz --delete"
DESTINATION="/personal/"

# Directories

rsync $RSYNC_OPTS /home/brett/.bin-personal/ /$DESTINATION/.bin-personal

rsync $RSYNC_OPTS /home/brett/.config/arcolinux-welcome-app/ /$DESTINATION/.config/arcolinux-welcome-app

#rsync $RSYNC_OPTS /home/brett/.config/autostart/ /$DESTINATION/.config/autostart

rsync $RSYNC_OPTS /home/brett/.config/arcolinux-betterlockscreen/ /$DESTINATION/.config/arcolinux-betterlockscreen

rsync $RSYNC_OPTS /home/brett/.config/dconf/ /$DESTINATION/.config/dconf

rsync $RSYNC_OPTS /home/brett/.config/i3/ /$DESTINATION/.config/i3

rsync $RSYNC_OPTS /home/brett/.config/polybar/ /$DESTINATION/.config/polybar

rsync $RSYNC_OPTS /home/brett/.config/Thunar/ /$DESTINATION/.config/Thunar

rsync $RSYNC_OPTS /home/brett/.config/variety/Fetched/ /$DESTINATION/.config/variety/Fetched

rsync $RSYNC_OPTS /home/brett/.config/xfce4/ /$DESTINATION/.config/xfce4

rsync $RSYNC_OPTS /home/brett/.local/share/applications/ /$DESTINATION/.local/share/applications


# files

rsync $RSYNC_OPTS /home/brett/.config/variety/variety.conf /$DESTINATION/.config/variety/variety.conf

rsync $RSYNC_OPTS /home/brett/.config/mimeapps.list /$DESTINATION/.config/mimeapps.list

