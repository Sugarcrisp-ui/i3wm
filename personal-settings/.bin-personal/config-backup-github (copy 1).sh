#!/bin/bash

set -e

# Define common rsync options
RSYNC_OPTS="-avh -r --exclude=.cache --mkpath --delete"
DEST="/home/brett/Github/i3wm/personal-settings"

# .bin-personal
rsync $RSYNC_OPTS /home/brett/.bin-personal/ $DEST/.bin-personal

# .config directories
rsync $RSYNC_OPTS /home/brett/.config/arcolinux-welcome-app/ $DEST/.config/arcolinux-welcome-app
rsync $RSYNC_OPTS /home/brett/.config/archlinux-betterlockscreen/ $DEST/.config/archlinux-betterlockscreen
rsync $RSYNC_OPTS /home/brett/.config/Cryptomator/ $DEST/.config/Cryptomator
rsync $RSYNC_OPTS /home/brett/.config/dconf/ $DEST/.config/dconf
rsync $RSYNC_OPTS /home/brett/.config/expressvpn/ $DEST/.config/expressvpn
rsync $RSYNC_OPTS /home/brett/.config/paru/ $DEST/.config/paru
rsync $RSYNC_OPTS /home/brett/.config/polybar/ $DEST/.config/polybar
rsync $RSYNC_OPTS /home/brett/.config/rofi/ $DEST/.config/rofi
rsync $RSYNC_OPTS /home/brett/.config/Thunar/ $DEST/.config/Thunar
rsync $RSYNC_OPTS /home/brett/.config/variety/Fetched/ $DEST/.config/variety/Fetched
rsync $RSYNC_OPTS /home/brett/.config/xfce4/ $DEST/.config/xfce4

# .config files
rsync $RSYNC_OPTS /home/brett/.config/i3/config $DEST/.config/i3/
rsync $RSYNC_OPTS /home/brett/.config/Code/User/settings.json $DEST/.config/Code/User/settings.json
rsync $RSYNC_OPTS /home/brett/.config/micro/settings.json $DEST/.config/micro/settings.json
rsync $RSYNC_OPTS /home/brett/.config/mimeapps.list $DEST/.config/mimeapps.list
rsync $RSYNC_OPTS /home/brett/.config/nano/nanorc $DEST/.config/nano/
rsync $RSYNC_OPTS /home/brett/.config/qBittorrent/qBittorrent.conf $DEST/.config/qBittorrent/

# .vscode directory
rsync $RSYNC_OPTS /home/brett/.vscode/ $DEST/.vscode

# .bashrc-personal directory
rsync $RSYNC_OPTS /home/brett/bashrc-personal/ $DEST/bashrc-personal/

# .bashrc-personal soft link
rsync $RSYNC_OPTS /home/brett/.bashrc-personal $DEST/

# etc directories
rsync $RSYNC_OPTS /etc/sddm.conf.d/ $DEST/etc/sddm.conf.d

# etc files
rsync $RSYNC_OPTS /etc/vconsole.conf $DEST/etc/
rsync $RSYNC_OPTS /etc/rc.local $DEST/etc/
rsync $RSYNC_OPTS /etc/mkinitcpio.conf $DEST/etc/

# sddm directories
rsync $RSYNC_OPTS /usr/share/sddm/themes/arcolinux-sugar-candy/ $DEST/usr/share/sddm/themes/arcolinux-sugar-candy

# usr files
rsync $RSYNC_OPTS /usr/share/gvfs/mounts/network.mount $DEST/usr/share/gvfs/mounts/
