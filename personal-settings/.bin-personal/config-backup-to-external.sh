#!/bin/bash

# Directories

rsync -r -t -p -o -g -v --progress -s --delete /home/brett/Appimages/ /home/brett/.local/share/Cryptomator/mnt/Arcolinux/Appimages

rsync -r -t -p -o -g -v --progress -s --delete /home/brett/.bin-personal/ /home/brett/.local/share/Cryptomator/mnt/Arcolinux/.bin-personal

rsync -r -t -p -o -g -v --progress -s --delete /home/brett/.config/arcolinux-betterlockscreen/ /home/brett/.local/share/Cryptomator/mnt/Arcolinux/.config/arcolinux-betterlockscreen

rsync -r -t -p -o -g -v --progress -s --delete /home/brett/.config/Cryptomator/ /home/brett/.local/share/Cryptomator/mnt/Arcolinux/.config/Cryptomator

rsync -r -t -p -o -g -v --progress -s --delete /home/brett/.config/dconf/ /home/brett/.local/share/Cryptomator/mnt/Arcolinux/.config/dconf

rsync -r -t -p -o -g -v --progress -s --delete /home/brett/.config/gtk-3.0/ /home/brett/.local/share/Cryptomator/mnt/Arcolinux/.config/gtk-3.0

rsync -r -t -p -o -g -v --progress -s --delete /home/brett/.config/expressvpn/ /home/brett/.local/share/Cryptomator/mnt/Arcolinux/.config/expressvpn

rsync -r -t -p -o -g -v --progress -s --delete /home/brett/.config/i3/ /home/brett/.local/share/Cryptomator/mnt/Arcolinux/.config/i3

rsync -r -t -p -o -g -v --progress -s --delete /home/brett/.config/Insync/ /home/brett/.local/share/Cryptomator/mnt/Arcolinux/.config/Insync

rsync -r -t -p -o -g -v --progress -s --delete /home/brett/.config/polybar/ /home/brett/.local/share/Cryptomator/mnt/Arcolinux/.config/polybar

rsync -r -t -p -o -g -v --progress -s --delete /home/brett/.config/ranger/ /home/brett/.local/share/Cryptomator/mnt/Arcolinux/.config/ranger

rsync -r -t -p -o -g -v --progress -s --delete /home/brett/.config/syncthing/ /home/brett/.local/share/Cryptomator/mnt/Arcolinux/.config/syncthing

rsync -r -t -p -o -g -v --progress -s --delete /home/brett/.config/Thunar/ /home/brett/.local/share/Cryptomator/mnt/Arcolinux/.config/Thunar

rsync -r -t -p -o -g -v --progress -s --delete /home/brett/.config/variety/Fetched/ /home/brett/.local/share/Cryptomator/mnt/Arcolinux/.config/variety/Fetched

rsync -r -t -p -o -g -v --progress -s --delete /home/brett/.config/xfce4/ /home/brett/.local/share/Cryptomator/mnt/Arcolinux/.config/xfce4

rsync -r -t -p -o -g -v --progress -s --delete /home/brett/.local/share/applications/ /home/brett/.local/share/Cryptomator/mnt/Arcolinux/.local/share/applications

rsync -r -t -p -o -g -v --progress -s --delete /home/brett/.local/share/ice/ /home/brett/.local/share/Cryptomator/mnt/Arcolinux/.local/share/ice

rsync -r -t -p -o -g -v --progress -s --delete /home/brett/.ssh/ /home/brett/.local/share/Cryptomator/mnt/Arcolinux/.ssh



# files

rsync -r -t -p -o -g -v --progress -s --delete /home/brett/.bashrc-personal /home/brett/.local/share/Cryptomator/mnt/Arcolinux/.bashrc-personal

rsync -r -t -p -o -g -v --progress -s --delete /home/brett/.config/variety/variety.conf /home/brett/.local/share/Cryptomator/mnt/Arcolinux/.config/variety/variety.conf