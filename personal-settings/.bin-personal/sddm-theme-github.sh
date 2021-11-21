#!/bin/bash

# Directories

rsync -r -t -p -o -g -v --progress -s /usr/share/sddm/themes/arcolinux-sugar-candy/Backgrounds/arco-login-plasma.jpg /home/brett/Github/personal-settings/arcolinux-sugar-candy/Backgrounds/arco-login-plasma.jpg --delete

rsync -r -t -p -o -g -v --progress -s /usr/share/sddm/themes/arcolinux-sugar-candy/Backgrounds/bluez-7650x5120.jpg /home/brett/Github/personal-settings/arcolinux-sugar-candy/Backgrounds/bluez-7650x5120.jpg --delete



# files

rsync -r -t -p -o -g -v --progress -s /usr/share/sddm/themes/arcolinux-sugar-candy/theme.conf /home/brett/Github/personal-settings/arcolinux-sugar-candy/theme.conf --delete

