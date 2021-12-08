#!/bin/bash

############################################################
#
# This section backs up xfce/i3wm
#
############################################################

# Directories

rsync -r -t -p -o -g -v --progress -s --delete /home/brett/.bin-personal/ /home/brett/Github/xfce/personal-settings/.bin-personal

rsync -r -t -p -o -g -v --progress -s --delete /home/brett/.config/arcolinux-welcome-app/ /home/brett/Github/xfce/personal-settings/arcolinux-welcome-app

rsync -r -t -p -o -g -v --progress -s --delete /home/brett/.config/autostart/ /home/brett/Github/xfce/personal-settings/autostart

rsync -r -t -p -o -g -v --progress -s --delete /home/brett/.config/arcolinux-betterlockscreen/ /home/brett/Github/xfce/personal-settings/.config/arcolinux-betterlockscreen

rsync -r -t -p -o -g -v --progress -s --delete /home/brett/.config/Cryptomator/ /home/brett/Github/xfce/personal-settings/.config/Cryptomator

rsync -r -t -p -o -g -v --progress -s --delete /home/brett/.config/dconf/ /home/brett/Github/xfce/personal-settings/.config/dconf

rsync -r -t -p -o -g -v --progress -s --delete /home/brett/.config/expressvpn/ /home/brett/Github/xfce/personal-settings/.config/expressvpn

rsync -r -t -p -o -g -v --progress -s --delete /home/brett/.config/gtk-3.0/ /home/brett/Github/xfce/personal-settings/.config/gtk-3.0

rsync -r -t -p -o -g -v --progress -s --delete /home/brett/.config/polybar/ /home/brett/Github/xfce/personal-settings/.config/polybar

rsync -r -t -p -o -g -v --progress -s --delete /home/brett/.config/ranger/ /home/brett/Github/xfce/personal-settings/.config/ranger

rsync -r -t -p -o -g -v --progress -s --delete /home/brett/.config/variety/Fetched/ /home/brett/Github/xfce/personal-settings/.config/variety/Fetched

rsync -r -t -p -o -g -v --progress -s --delete /home/brett/.config/xfce4/ /home/brett/Github/xfce/personal-settings/.config/xfce4

rsync -r -t -p -o -g -v --progress -s --delete /home/brett/.local/share/applications/ /home/brett/Github/xfce/personal-settings/.local/share/applications



# files

rsync -r -t -p -o -g -v --progress -s --delete /home/brett/.bashrc-personal /home/brett/Github/xfce/personal-settings/.bashrc-personal

rsync -r -t -p -o -g -v --progress -s --delete /home/brett/.config/i3/config /home/brett/Github/xfce/personal-settings/.config/i3/config

rsync -r -t -p -o -g -v --progress -s --delete /home/brett/.config/variety/variety.conf /home/brett/Github/xfce/personal-settings/.config/variety/variety.conf


################################################################################################################################################


############################################################
#
# This section backs up i3wm
#
############################################################

# Directories

rsync -r -t -p -o -g -v --progress -s --delete /home/brett/.bin-personal/ /home/brett/Github/i3wm/personal-settings/.bin-personal

rsync -r -t -p -o -g -v --progress -s --delete /home/brett/.config/arcolinux-welcome-app/ /home/brett/Github/i3wm/personal-settings/arcolinux-welcome-app

rsync -r -t -p -o -g -v --progress -s --delete /home/brett/.config/autostart/ /home/brett/Github/i3wm/personal-settings/autostart

rsync -r -t -p -o -g -v --progress -s --delete /home/brett/.config/arcolinux-betterlockscreen/ /home/brett/Github/i3wm/personal-settings/.config/arcolinux-betterlockscreen

rsync -r -t -p -o -g -v --progress -s --delete /home/brett/.config/Cryptomator/ /home/brett/Github/i3wm/personal-settings/.config/Cryptomator

rsync -r -t -p -o -g -v --progress -s --delete /home/brett/.config/dconf/ /home/brett/Github/i3wm/personal-settings/.config/dconf

rsync -r -t -p -o -g -v --progress -s --delete /home/brett/.config/expressvpn/ /home/brett/Github/i3wm/personal-settings/.config/expressvpn

rsync -r -t -p -o -g -v --progress -s --delete /home/brett/.config/gtk-3.0/ /home/brett/Github/i3wm/personal-settings/.config/gtk-3.0

rsync -r -t -p -o -g -v --progress -s --delete /home/brett/.config/polybar/ /home/brett/Github/i3wm/personal-settings/.config/polybar

rsync -r -t -p -o -g -v --progress -s --delete /home/brett/.config/ranger/ /home/brett/Github/i3wm/personal-settings/.config/ranger

rsync -r -t -p -o -g -v --progress -s --delete /home/brett/.config/Thunar/ /home/brett/Github/i3wm/personal-settings/.config/Thunar

rsync -r -t -p -o -g -v --progress -s --delete /home/brett/.config/variety/Fetched/ /home/brett/Github/i3wm/personal-settings/.config/variety/Fetched

rsync -r -t -p -o -g -v --progress -s --delete /home/brett/.config/xfce4/ /home/brett/Github/i3wm/personal-settings/.config/xfce4



# files

rsync -r -t -p -o -g -v --progress -s --delete /home/brett/.bashrc-personal /home/brett/Github/i3wm/personal-settings/.bashrc-personal

rsync -r -t -p -o -g -v --progress -s --delete /home/brett/.config/i3/config /home/brett/Github/i3wm/personal-settings/.config/i3/config

rsync -r -t -p -o -g -v --progress -s --delete /home/brett/.config/variety/variety.conf /home/brett/Github/i3wm/personal-settings/.config/variety/variety.conf
