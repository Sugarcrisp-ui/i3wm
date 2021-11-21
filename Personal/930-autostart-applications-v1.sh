#!/bin/bash
# The set command is used to determine action if error 
# is encountered.  (-e) will stop and exit (+e) will 
# continue with the script.
set +e

[ -d $HOME"/.config/autostart" ] || mkdir -p $HOME"/.config/autostart"

sleep 1

installed_dir=$(dirname $(readlink -f $(basename `pwd`)))


cp -f $installed_dir/settings/autostart/* $HOME"/.config/autostart"

echo "################################################################"
echo "####                      autostart added                 ######"
echo "################################################################"
