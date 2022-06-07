#!/bin/bash
# The set command is used to determine action if error 
# is encountered.  (-e) will stop and exit (+e) will 
# continue with the script.
set +e
##################################################################################################################


echo "################################################################"
echo "#########          Installing bookmarks         ################"
echo "################################################################"


cp ~/i3wm/personal-settings/.config/gtk-3.0/* ~/.config/gtk-3.0/


echo "################################################################"
echo "#########       personal settings installed     ################"
echo "################################################################"
