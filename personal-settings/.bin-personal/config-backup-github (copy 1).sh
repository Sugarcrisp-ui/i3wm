#!/bin/bash

# Define common rsync options
RSYNC_OPTS="-r -t -p -o -g -v --progress -s --delete"

# Directories
rsync $RSYNC_OPTS /home/brett/.bin-personal/ /home/brett/Github/i3wm/personal-settings/.bin-personal
rsync $RSYNC_OPTS /home/brett/.config/arcolinux-welcome-app/ /home/brett/Github/i3wm/personal-settings/arcolinux-welcome-app
rsync $RSYNC_OPTS /home/brett/.config/arcolinux-betterlockscreen/ /home/brett/Github/i3wm/personal-settings/.config/arcolinux-betterlockscreen
rsync $RSYNC_OPTS /home/brett/.config/Cryptomator/ /home/brett/Github/i3wm/personal-settings/.config/Cryptomator
rsync $RSYNC_OPTS /home/brett/.config/dconf/ /home/brett/Github/i3wm/personal-settings/.config/dconf
rsync $RSYNC_OPTS /home/brett/.config/expressvpn/ /home/brett/Github/i3wm/personal-settings/.config/expressvpn
rsync $RSYNC_OPTS /home/brett/.config/gtk-3.0/ /home/brett/Github/i3wm/personal-settings/.config/gtk-3.0
rsync $RSYNC_OPTS /home/brett/.config/polybar/ /home/brett/Github/i3wm/personal-settings/.config/polybar
rsync $RSYNC_OPTS /home/brett/.config/ranger/ /home/brett/Github/i3wm/personal-settings/.config/ranger
rsync $RSYNC_OPTS /home/brett/.config/Thunar/ /home/brett/Github/i3wm/personal-settings/.config/Thunar
rsync $RSYNC_OPTS /home/brett/.config/variety/Fetched/ /home/brett/Github/i3wm/personal-settings/.config/variety/Fetched
rsync $RSYNC_OPTS /home/brett/.config/xfce4/ /home/brett/Github/i3wm/personal-settings/.config/xfce4
rsync $RSYNC_OPTS /home/brett/.screenlayout/ /home/brett/Github/i3wm/personal-settings/.screenlayout

# Files
rsync $RSYNC_OPTS /home/brett/.bashrc-personal /home/brett/Github/i3wm/personal-settings/.bashrc-personal
rsync $RSYNC_OPTS /home/brett/.config/i3/config /home/brett/Github/i3wm/personal-settings/.config/i3/config
rsync $RSYNC_OPTS /home/brett/.config/variety/variety.conf /home/brett/Github/i3wm/personal-settings/.config/variety/variety.conf
