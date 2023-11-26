#!/bin/bash

# Rsync options
RSYNC_OPTS="-av --delete --exclude '.cache'"

# Backup destination
BACKUP_DIR="/home/brett/Github2/i3wm/personal-settings"

# Create needed dirs
mkdir -p "$BACKUP_DIR/."  

# Backup specific .config dirs
rsync $RSYNC_OPTS /home/brett/.config/arcolinux-welcome-app/ "$BACKUP_DIR/.config/arcolinux-welcome-app"
rsync $RSYNC_OPTS /home/brett/.config/archlinux-betterlockscreen/ "$BACKUP_DIR/.config/archlinux-betterlockscreen"
rsync $RSYNC_OPTS /home/brett/.config/Cryptomator/ "$BACKUP_DIR/.config/Cryptomator"
rsync $RSYNC_OPTS /home/brett/.config/dconf/ "$BACKUP_DIR/.config/dconf" 
rsync $RSYNC_OPTS /home/brett/.config/expressvpn/ "$BACKUP_DIR/.config/expressvpn"
rsync $RSYNC_OPTS /home/brett/.config/gtk-3.0/ "$BACKUP_DIR/.config/gtk-3.0"
rsync $RSYNC_OPTS --include=config /home/brett/.config/i3/ "$BACKUP_DIR/.config/i3"
rsync $RSYNC_OPTS /home/brett/.config/polybar/ "$BACKUP_DIR/.config/polybar"  
rsync $RSYNC_OPTS /home/brett/.config/Thunar/ "$BACKUP_DIR/.config/Thunar"
rsync $RSYNC_OPTS /home/brett/.config/variety/Fetched/ "$BACKUP_DIR/.config/variety/Fetched"
rsync $RSYNC_OPTS /home/brett/.config/xfce4/ "$BACKUP_DIR/.config/xfce4"

# Backup .bin-personal
rsync $RSYNC_OPTS /home/brett/.bin-personal/ "$BACKUP_DIR/.bin-personal"

# Backup .local  
rsync $RSYNC_OPTS /home/brett/.local/share/ice/firefox/ "$BACKUP_DIR/.local/share/ice/firefox" 
rsync $RSYNC_OPTS /home/brett/.local/share/ice/profiles/ "$BACKUP_DIR/.local/share/ice/profiles"
rsync -av /home/brett/.local/share/applications/ "$BACKUP_DIR/.local/share/applications"

# Backup sddm themes
rsync -av /usr/share/sddm/themes/arcolinux-sugar-candy/ "$BACKUP_DIR/usr/share/sddm/themes/arcolinux-sugar-candy"  

# Backup individual files 
rsync $RSYNC_OPTS /home/brett/.bashrc-personal "$BACKUP_DIR"
rsync $RSYNC_OPTS /etc/vconsole.conf "$BACKUP_DIR/etc"  
rsync $RSYNC_OPTS /etc/rc.local "$BACKUP_DIR/etc"
rsync $RSYNC_OPTS /etc/mkinitcpio.conf "$BACKUP_DIR/etc" 
rsync $RSYNC_OPTS /usr/share/gvfs/mounts/network.mount "$BACKUP_DIR/usr/share/gvfs/mounts"
