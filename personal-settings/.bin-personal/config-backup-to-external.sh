#!/bin/bash

# Directories

rsync -r -t -p -o -g -v --progress -s --delete /home/brett/.bin-personal/ /run/media/brett/Backup1/.bin-personal

rsync -r -t -p -o -g -v --progress -s --delete --exclude-from={'Insync/', 'chromium/'} /home/brett/.config/ /run/media/brett/Backup1/.config

rsync -r -t -p -o -g -v --progress -s --delete --exclude-from='Trash/' /home/brett/.local/ /run/media/brett/Backup1/.local

rsync -r -t -p -o -g -v --progress -s --delete /home/brett/.ssh/ /run/media/brett/Backup1/.ssh

rsync -r -t -p -o -g -v --progress -s --delete /home/brett/.var/ /run/media/brett/Backup1/.var

rsync -r -t -p -o -g -v --progress -s --delete /home/brett/.vnc/ /run/media/brett/Backup1/.vnc

rsync -r -t -p -o -g -v --progress -s --delete /home/brett/Appimages/ /run/media/brett/Backup1/Appimages

rsync -r -t -p -o -g -v --progress -s --delete /home/brett/Documents/ /run/media/brett/Backup1/Documents

rsync -r -t -p -o -g -v --progress -s --delete /home/brett/Downloads/ /run/media/brett/Backup1/Downloads

rsync -r -t -p -o -g -v --progress -s --delete /home/brett/Pictures/ /run/media/brett/Backup1/Pictures

rsync -r -t -p -o -g -v --progress -s --delete /home/brett/"VirtualBox VMs"/ /run/media/brett/Backup1/"VirtualBox VMs"

rsync -r -t -p -o -g -v --progress -s --delete /home/brett/Webapps/ /run/media/brett/Backup1/Webapps



# files

rsync -r -t -p -o -g -v --progress -s --delete /home/brett/.bashrc-personal /run/media/brett/Backup1/.bashrc-personal

rsync -r -t -p -o -g -v --progress -s --delete /home/brett/.config/variety/variety.conf /run/media/brett/Backup1/.config/variety/variety.conf

