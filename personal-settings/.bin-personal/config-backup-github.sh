#!/bin/bash

set -e

# Define common rsync options
RSYNC_OPTS="-avh -r --exclude=.cache --mkpath --delete"
DEST="/home/brett/Github/i3wm/personal-settings"

# Directories
rsync $RSYNC_OPTS /home/brett/.bin-personal/ $DEST/.bin-personal 
rsync $RSYNC_OPTS /home/brett/.config/arcolinux-welcome-app/ $DEST/arcolinux-welcome-app
rsync $RSYNC_OPTS /home/brett/.config/archlinux-betterlockscreen/ $DEST/.config/
rsync $RSYNC_OPTS /home/brett/.config/Cryptomator/ $DEST/.config/Cryptomator
rsync $RSYNC_OPTS /home/brett/.config/dconf/ $DEST/.config/dconf
rsync $RSYNC_OPTS /home/brett/.config/expressvpn/ $DEST/.config/expressvpn
rsync $RSYNC_OPTS /home/brett/.config/polybar/ $DEST/.config/polybar
rsync $RSYNC_OPTS /home/brett/.config/rofi/ $DEST/.config/rofi
rsync $RSYNC_OPTS /home/brett/.config/Thunar/ $DEST/.config/Thunar
rsync $RSYNC_OPTS /home/brett/.config/variety/Fetched/ $DEST/.config/variety/Fetched
rsync $RSYNC_OPTS /home/brett/.config/xfce4/ $DEST/.config/xfce4
rsync $RSYNC_OPTS /home/brett/.vscode/ $DEST/.vscode
rsync $RSYNC_OPTS /home/brett/bashrc-personal/ $DEST/bashrc-personal/
rsync $RSYNC_OPTS /usr/share/sddm/themes/arcolinux-sugar-candy/ $DEST/arcolinux-sugar-candy


# Files
rsync $RSYNC_OPTS /home/brett/.bashrc-personal $DEST/
rsync $RSYNC_OPTS /home/brett/.config/i3/config $DEST/.config/i3/
rsync $RSYNC_OPTS /home/brett/.config/Code/User/settings.json $DEST/.config/Code/User/settings.json
rsync $RSYNC_OPTS /home/brett/.config/qBittorrent/qBittorrent.conf $DEST/.config/qBittorrent/
rsync $RSYNC_OPTS /etc/vconsole.conf $DEST/etc/
rsync $RSYNC_OPTS /etc/rc.local $DEST/etc/
rsync $RSYNC_OPTS /etc/mkinitcpio.conf $DEST/etc/
rsync $RSYNC_OPTS /usr/share/gvfs/mounts/network.mount $DEST/usr/share/gvfs/mounts/
