#!/bin/bash

# Directories

rsync -avi --progress --delete /home/brett/.config/arcolinux-welcome-app/ /personal/.config/arcolinux-welcome-app

rsync -avi --progress --delete /home/brett/.config/autostart/ /personal/.config/autostart

rsync -avi --progress --delete /home/brett/.config/arcolinux-betterlockscreen/ /personal/.config/arcolinux-betterlockscreen

rsync -avi --progress --delete /home/brett/.config/dconf/ /personal/.config/dconf

rsync -avi --progress --delete /home/brett/.config/i3/ /personal/.config/i3

rsync -avi --progress --delete /home/brett/.config/polybar/ /personal/.config/polybar

rsync -avi --progress --delete /home/brett/.config/Thunar/ /personal/.config/Thunar

rsync -avi --progress --delete /home/brett/.config/variety/Fetched/ /personal/.config/variety/Fetched

rsync -avi --progress --delete /home/brett/.config/xfce4/ /personal/.config/xfce4

rsync -avi --progress --delete /home/brett/.local/share/applications/ /personal/.local/share/applications

rsync -avi --progress --delete /home/brett/.local/share/ice/ /personal/.local/share/ice


# files

rsync -avi --progress --delete /home/brett/.config/variety/variety.conf /personal/.config/variety/variety.conf


# switch to home directory
cd ~
exec bash
