#!/bin/bash

# Define common rsync options
RSYNC_OPTS="-r -t -p -o -g -v --progress -s --delete"

# Directories

rsync $RSYNC_OPTS /home/brett/.bin-personal/ /personal/.bin-personal

rsync $RSYNC_OPTS /home/brett/.config/arcolinux-welcome-app/ /personal/.config/arcolinux-welcome-app

#rsync $RSYNC_OPTS /home/brett/.config/autostart/ /personal/.config/autostart

rsync $RSYNC_OPTS /home/brett/.config/arcolinux-betterlockscreen/ /personal/.config/arcolinux-betterlockscreen

rsync $RSYNC_OPTS /home/brett/.config/dconf/ /personal/.config/dconf

rsync $RSYNC_OPTS /home/brett/.config/i3/ /personal/.config/i3

rsync $RSYNC_OPTS /home/brett/.config/polybar/ /personal/.config/polybar

rsync $RSYNC_OPTS /home/brett/.config/Thunar/ /personal/.config/Thunar

rsync $RSYNC_OPTS /home/brett/.config/variety/Fetched/ /personal/.config/variety/Fetched

rsync $RSYNC_OPTS /home/brett/.config/xfce4/ /personal/.config/xfce4

rsync $RSYNC_OPTS /home/brett/.local/share/applications/ /personal/.local/share/applications


# files

rsync $RSYNC_OPTS /home/brett/.config/variety/variety.conf /personal/.config/variety/variety.conf

rsync $RSYNC_OPTS /home/brett/.config/mimeapps.list /personal/.config/mimeapps.list

