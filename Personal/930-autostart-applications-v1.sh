#!/bin/bash
# The set command is used to determine action if error 
# is encountered.  (-e) will stop and exit (+e) will 
# continue with the script.
set +e

[ -d $HOME"/.config/autostart" ] || mkdir -p $HOME"/.config/autostart"

sleep 1

cp -Rf ~/i3wm/personal-settings/autostart/* ~/.config/autostart

echo "################################################################"
echo "####                      autostart added                 ######"
echo "################################################################"
