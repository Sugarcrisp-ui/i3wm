#!/bin/bash

# Define common rsync options
RSYNC_OPTS="-avz --delete"
DESTINATION="/home/brett/Github/i3wm/personal-settings"

# Directories
rsync $RSYNC_OPTS /home/brett/.bin-personal/ $DESTINATION/.bin-personal
rsync $RSYNC_OPTS /home/brett/.config/arcolinux-welcome-app/ $DESTINATION/arcolinux-welcome-app
rsync $RSYNC_OPTS /home/brett/.config/arcolinux-betterlockscreen/ $DESTINATION/.config/arcolinux-betterlockscreen
rsync $RSYNC_OPTS /home/brett/.config/Cryptomator/ $DESTINATION/.config/Cryptomator
rsync $RSYNC_OPTS /home/brett/.config/dconf/ $DESTINATION/.config/dconf
rsync $RSYNC_OPTS /home/brett/.config/expressvpn/ $DESTINATION/.config/expressvpn
rsync $RSYNC_OPTS /home/brett/.config/gtk-3.0/ $DESTINATION/.config/gtk-3.0
rsync $RSYNC_OPTS /home/brett/.config/polybar/ $DESTINATION/.config/polybar
rsync $RSYNC_OPTS /home/brett/.config/ranger/ $DESTINATION/.config/ranger
rsync $RSYNC_OPTS /home/brett/.config/Thunar/ $DESTINATION/.config/Thunar
rsync $RSYNC_OPTS /home/brett/.config/variety/Fetched/ $DESTINATION/.config/variety/Fetched
rsync $RSYNC_OPTS /home/brett/.config/xfce4/ $DESTINATION/.config/xfce4
rsync $RSYNC_OPTS /usr/share/sddm/themes/arcolinux-sugar-candy/ $DESTINATION/arcolinux-sugar-candy --delete


# Files
rsync $RSYNC_OPTS /home/brett/.bashrc-personal $DESTINATION/
rsync $RSYNC_OPTS /home/brett/.config/i3/config $DESTINATION/
rsync $RSYNC_OPTS /home/brett/.config/variety/variety.conf $DESTINATION/.config/variety/
rsync $RSYNC_OPTS /etc/systemd/system/vpn-autostart.service $DESTINATION/etc/systemd/system/
rsync $RSYNC_OPTS /etc/systemd/system/vpn-autostart-suspend.service $DESTINATION/etc/systemd/system/
rsync $RSYNC_OPTS /etc/systemd/system/cryptomator.service $DESTINATION/etc/systemd/system/
rsync $RSYNC_OPTS /etc/systemd/system/insync.service $DESTINATION/etc/systemd/system
rsync $RSYNC_OPTS /etc/vconsole.conf $DESTINATION/etc/
