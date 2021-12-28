#!/bin/bash

# Directories

rsync -r -t -p -o -g -v --progress -s --delete /home/brett/.bin-personal/ /home/brett/.local/share/Cryptomator/mnt/Arcolinux/.bin-personal

rsync -r -t -p -o -g -v --progress -s --delete --exclude 'Insync' 'chromium' /home/brett/.config/ /home/brett/.local/share/Cryptomator/mnt/Arcolinux/.config

rsync -r -t -p -o -g -v --progress -s --delete /home/brett/.local/share/applications/ /home/brett/.local/share/Cryptomator/mnt/Arcolinux/.local/share/applications

rsync -r -t -p -o -g -v --progress -s --delete /home/brett/.local/share/ice/ /home/brett/.local/share/Cryptomator/mnt/Arcolinux/.local/share/ice

rsync -r -t -p -o -g -v --progress -s --delete /home/brett/.ssh/ /home/brett/.local/share/Cryptomator/mnt/Arcolinux/.ssh

rsync -r -t -p -o -g -v --progress -s --delete /home/brett/.var/ /home/brett/.local/share/Cryptomator/mnt/Arcolinux/.var

rsync -r -t -p -o -g -v --progress -s --delete /home/brett/.vnc/ /home/brett/.local/share/Cryptomator/mnt/Arcolinux/.vnc

rsync -r -t -p -o -g -v --progress -s --delete /home/brett/Downloads/ /home/brett/.local/share/Cryptomator/mnt/Arcolinux/Downloads

rsync -r -t -p -o -g -v --progress -s --delete /home/brett/Pictures/ /home/brett/.local/share/Cryptomator/mnt/Arcolinux/Pictures

rsync -r -t -p -o -g -v --progress -s --delete /home/brett/Webapps/ /home/brett/.local/share/Cryptomator/mnt/Arcolinux/Webapps



# files

rsync -r -t -p -o -g -v --progress -s --delete /home/brett/.bashrc-personal /home/brett/.local/share/Cryptomator/mnt/Arcolinux/.bashrc-personal

rsync -r -t -p -o -g -v --progress -s --delete /home/brett/.config/variety/variety.conf /home/brett/.local/share/Cryptomator/mnt/Arcolinux/.config/variety/variety.conf
