#!/bin/bash

# Directories

rsync -r -t -p -o -g -v --progress -s --delete /home/brett/.bin-personal/ /personal/.bin-personal

rsync -r -t -p -o -g -v --progress -s --delete /home/brett/.config/arcolinux-welcome-app/ /personal/.config/arcolinux-welcome-app

rsync -r -t -p -o -g -v --progress -s --delete /home/brett/.config/autostart/ /personal/.config/autostart

rsync -r -t -p -o -g -v --progress -s --delete /home/brett/.config/arcolinux-betterlockscreen/ /personal/.config/arcolinux-betterlockscreen

rsync -r -t -p -o -g -v --progress -s --delete /home/brett/.config/dconf/ /personal/.config/dconf

rsync -r -t -p -o -g -v --progress -s --delete /home/brett/.config/i3/ /personal/.config/i3

rsync -r -t -p -o -g -v --progress -s --delete /home/brett/.config/polybar/ /personal/.config/polybar

rsync -r -t -p -o -g -v --progress -s --delete /home/brett/.config/Thunar/ /personal/.config/Thunar

rsync -r -t -p -o -g -v --progress -s --delete /home/brett/.config/variety/Fetched/ /personal/.config/variety/Fetched

rsync -r -t -p -o -g -v --progress -s --delete /home/brett/.config/xfce4/ /personal/.config/xfce4


# files

rsync -r -t -p -o -g -v --progress -s --delete /home/brett/.config/variety/variety.conf /personal/.config/variety/variety.conf

