#!/bin/bash

# Directories

rsync -av --progress /var/spool/cron/* /home/brett/Github/personal-settings/cron --delete

chown brett:brett /home/brett/Github/personal-settings/cron/root



# files


