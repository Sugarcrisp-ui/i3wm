#!/bin/bash

# to external drive
# set to autorun twice a day in cron
rsync -r -t -p -o -g -v --progress -s /home/brett/"VirtualBox VMs"/ /mnt/057c65a9-7f0e-4e18-a733-74d60d7c1e5e/"VirtualBox VMs" --delete

# from external drive
#rsync -r -t -p -o -g -v --progress -s /mnt/057c65a9-7f0e-4e18-a733-74d60d7c1e5e/"VirtualBox VMs"/ /home/brett/"VirtualBox VMs" --delete
