#!/bin/bash

# Directories

rsync -r -t -p -o -g -v --progress -s /home/brett/Appimages/ /home/brett/.local/share/Cryptomator/mnt/Arcolinux/Appimages --delete

rsync -r -t -p -o -g -v --progress -s /home/brett/.bin-personal/ /home/brett/.local/share/Cryptomator/mnt/Arcolinux/.bin-personal --delete

rsync -r -t -p -o -g -v --progress -s /home/brett/.config/arcolinux-betterlockscreen/ /home/brett/.local/share/Cryptomator/mnt/Arcolinux/.config/arcolinux-betterlockscreen --delete

rsync -r -t -p -o -g -v --progress -s /home/brett/.config/Cryptomator/ /home/brett/.local/share/Cryptomator/mnt/Arcolinux/.config/Cryptomator --delete

rsync -r -t -p -o -g -v --progress -s /home/brett/.config/dconf/ /home/brett/.local/share/Cryptomator/mnt/Arcolinux/.config/dconf --delete

rsync -r -t -p -o -g -v --progress -s /home/brett/.config/gtk-3.0/ /home/brett/.local/share/Cryptomator/mnt/Arcolinux/.config/gtk-3.0 --delete

rsync -r -t -p -o -g -v --progress -s /home/brett/.config/expressvpn/ /home/brett/.local/share/Cryptomator/mnt/Arcolinux/.config/expressvpn --delete

rsync -r -t -p -o -g -v --progress -s /home/brett/.config/i3/ /home/brett/.local/share/Cryptomator/mnt/Arcolinux/.config/i3 --delete

rsync -r -t -p -o -g -v --progress -s /home/brett/.config/Insync/ /home/brett/.local/share/Cryptomator/mnt/Arcolinux/.config/Insync --delete

rsync -r -t -p -o -g -v --progress -s /home/brett/.config/polybar/ /home/brett/.local/share/Cryptomator/mnt/Arcolinux/.config/polybar --delete

rsync -r -t -p -o -g -v --progress -s /home/brett/.config/ranger/ /home/brett/.local/share/Cryptomator/mnt/Arcolinux/.config/ranger --delete

rsync -r -t -p -o -g -v --progress -s /home/brett/.config/syncthing/ /home/brett/.local/share/Cryptomator/mnt/Arcolinux/.config/syncthing --delete

rsync -r -t -p -o -g -v --progress -s /home/brett/.config/Thunar/ /home/brett/.local/share/Cryptomator/mnt/Arcolinux/.config/Thunar --delete

rsync -r -t -p -o -g -v --progress -s /home/brett/.config/variety/Fetched/ /home/brett/.local/share/Cryptomator/mnt/Arcolinux/.config/variety/Fetched --delete

rsync -r -t -p -o -g -v --progress -s /home/brett/.config/xfce4/ /home/brett/.local/share/Cryptomator/mnt/Arcolinux/.config/xfce4 --delete

rsync -r -t -p -o -g -v --progress -s /home/brett/.local/share/applications/ /home/brett/.local/share/Cryptomator/mnt/Arcolinux/.local/share/applications --delete

rsync -r -t -p -o -g -v --progress -s /home/brett/.local/share/ice/ /home/brett/.local/share/Cryptomator/mnt/Arcolinux/.local/share/ice --delete

rsync -r -t -p -o -g -v --progress -s /home/brett/.ssh/ /home/brett/.local/share/Cryptomator/mnt/Arcolinux/.ssh --delete



# files

rsync -r -t -p -o -g -v --progress -s /home/brett/.bashrc-personal /home/brett/.local/share/Cryptomator/mnt/Arcolinux/.bashrc-personal --delete

rsync -r -t -p -o -g -v --progress -s /home/brett/.config/variety/variety.conf /home/brett/.local/share/Cryptomator/mnt/Arcolinux/.config/variety/variety.conf --delete