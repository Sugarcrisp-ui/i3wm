#!/bin/bash

set -e

# Define common rsync options
RSYNC_OPTS="-avz"
DESTINATION="/home/brett/Github/i3wm/personal-settings"

# Directories
rsync $RSYNC_OPTS /home/brett/.bin-personal/ $DESTINATION/.bin-personal > /home/brett/my-rsync-log-files/github/github.bin-personal.log 2>&1 || echo "Error: rsync failed for .bin-personal"
rsync $RSYNC_OPTS /home/brett/.config/arcolinux-welcome-app/ $DESTINATION/arcolinux-welcome-app > /home/brett/my-rsync-log-files/github/github.arclinux-welcome-app.log 2>&1 || echo "Error: rsync failed for arcolinux-welcome-app"
rsync $RSYNC_OPTS /home/brett/.config/archlinux-betterlockscreen/ $DESTINATION/.config/ > /home/brett/my-rsync-log-files/github/github.archlinux-betterlockscreen.log 2>&1 || echo "Error: rsync failed for archlinux-betterlockscreen"
rsync $RSYNC_OPTS /home/brett/.config/Cryptomator/ $DESTINATION/.config/Cryptomator > /home/brett/my-rsync-log-files/github/github.Cryptomator.log 2>&1 || echo "Error: rsync failed for Cryptomator"
rsync $RSYNC_OPTS /home/brett/.config/dconf/ $DESTINATION/.config/dconf > /home/brett/my-rsync-log-files/github/github.dconf.log 2>&1 || echo "Error: rsync failed for dconf"
rsync $RSYNC_OPTS /home/brett/.config/expressvpn/ $DESTINATION/.config/expressvpn > /home/brett/my-rsync-log-files/github/github.expressvpn.log 2>&1 || echo "Error: rsync failed for expressvpn"
rsync $RSYNC_OPTS /home/brett/.config/gtk-3.0/ $DESTINATION/.config/gtk-3.0 > /home/brett/my-rsync-log-files/github/githubgtk-3.0.log 2>&1 || echo "Error: rsync failed for gtk-3.0"
rsync $RSYNC_OPTS /home/brett/.config/polybar/ $DESTINATION/.config/polybar > /home/brett/my-rsync-log-files/github/github.polybar.log 2>&1 || echo "Error: rsync failed for polybar"
rsync $RSYNC_OPTS /home/brett/.config/Thunar/ $DESTINATION/.config/Thunar > /home/brett/my-rsync-log-files/github/github.Thunar.log 2>&1 || echo "Error: rsync failed for Thunar"
rsync $RSYNC_OPTS /home/brett/.config/variety/Fetched/ $DESTINATION/.config/variety/Fetched > /home/brett/my-rsync-log-files/github/github.variety.log 2>&1 || echo "Error: rsync failed for variety"
rsync $RSYNC_OPTS /home/brett/.config/xfce4/ $DESTINATION/.config/xfce4 > /home/brett/my-rsync-log-files/github/github.xfce4.log 2>&1 || echo "Error: rsync failed for xfce4"
rsync $RSYNC_OPTS /home/brett/.local/share/ice/ $DESTINATION/.local
rsync $RSYNC_OPTS /home/brett/bashrc-personal/ $DESTINATION > /home/brett/my-rsync-log-files/bashrc-personal.log 2>&1 || echo "Error: rsync failed for bashrc-personal"
rsync $RSYNC_OPTS /usr/share/sddm/themes/arcolinux-sugar-candy/ $DESTINATION/arcolinux-sugar-candy > /home/brett/my-rsync-log-files/github/github.arcolinux-sugar-candy.log 2>&1 || echo "Error: rsync failed for arcolinux-sugar-candy"


# Files
rsync $RSYNC_OPTS /home/brett/.bashrc-personal $DESTINATION/ > /home/brett/my-rsync-log-files/github/github.bashrc-personal.log 2>&1 || echo "Error: rsync failed for bashrc-personal"
rsync $RSYNC_OPTS /home/brett/.config/i3/config $DESTINATION/.config/i3/ > /home/brett/my-rsync-log-files/github/github.i3-config.log 2>&1 || echo "Error: rsync failed for i3-confg"
rsync $RSYNC_OPTS /home/brett/.config/variety/variety.conf $DESTINATION/.config/variety/ > /home/brett/my-rsync-log-files/github/github.variety.conf.log 2>&1 || echo "Error: rsync failed for variety.conf"
rsync $RSYNC_OPTS /etc/vconsole.conf $DESTINATION/etc/ > /home/brett/my-rsync-log-files/github/github.vconsole.conf.log 2>&1 || echo "Error: rsync failed for vconsole.conf"
rsync $RSYNC_OPTS /etc/rc.local $DESTINATION/etc/ > /home/brett/my-rsync-log-files/github/github.rc.local.log 2>&1 || echo "Error: rsync failed for rc.local"
rsync $RSYNC_OPTS /usr/share/gvfs/mounts/network.mount $DESTINATION/usr/share/gvfs/mounts/ > /home/brett/my-rsync-log-files/github/github.network.mount.log 2>&1 || echo "Error: rsync failed for network.mount"
rsync $RSYNC_OPTS --include='webapp*' --exclude='*' ~/.local/share/applications/ $DESTINATION/.local/share/applications/ > /home/brett/my-rsync-log-files/github/github.local-share-applications.log 2>&1 || echo "Error: rsync failed for local-share-applications"
rsync $RSYNC_OPTS /etc/mkinitcpio.conf $DESTINATION/etc/ > /home/brett/my-rsync-log-files/github/github.mkinitcpio.conf.log 2>&1 || echo "Error: rsync failed for mkinitcpio.conf"
