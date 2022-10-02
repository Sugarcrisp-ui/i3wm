#!/bin/bash
# The set command is used to determine action if error 
# is encountered.  (-e) will stop and exit (+e) will 
# continue with the script.
set +e

##################################################################################################################
#tput setaf 0 = black #tput setaf 1 = red #tput setaf 2 = green
#tput setaf 3 = yellow #tput setaf 4 = dark blue #tput setaf 5 = purple
#tput setaf 6 = cyan #tput setaf 7 = gray #tput setaf 8 = light blue

#https://github.com/systemd/zram-generator

sudo pacman -S zram-generator --noconfrim --needed

#----------------------------------------------------------------------------------

echo '[zram0]
zram-size = ram / 2' | tee /etc/systemd/zram-generator.conf

#create new devices
sudo systemctl daemon-reload

sudo systemctl start /dev/zram0

echo "check with"
echo "swapon or zramctl or"
echo "with systemdsystemctl status systemd-zram-setup@zram0.service
"
#----------------------------------------------------------------------------------
