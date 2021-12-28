#!/bin/bash

# to external drive
# set to autorun twice a day in cron
rsync -r -t -p -o -g -v --progress -s --delete /home/brett/Videos/ /run/media/brett/Backup1/Videos

# from external drive
#rsync -r -t -p -o -g -v --progress -s --delete /run/media/brett/Backup1/videos/ /home/brett/Videos
