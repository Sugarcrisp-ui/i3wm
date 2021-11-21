#!/bin/bash

# Directories

rsync -r -t -p -o -g -v --progress -s /var/spool/cron/* /home/brett/Github/personal-settings/cron --delete

chown brett:brett /home/brett/Github/personal-settings/cron/root



# files


