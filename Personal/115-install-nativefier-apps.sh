#!/bin/bash
# The set command is used to determine action if error
# is encountered.  (-e) will stop and exit (+e) will
# continue with the script.
set -e
###############################################################################
# Author	:	Brett Crisp
###############################################################################


nativefier --name "Facebook Messenger" "https://www.facebook.com/messages/t/6143117129045315/"

nativefier --name "Twitter" "https://www.twitter.com"

nativefier --name "Whatsapp" "https://web.whatsapp.com"

cp /home/brett/i3wm/Personal/nativefier/* /home/brett/.local/share/applications/


###############################################################################

tput setaf 11
echo "################################################################"
echo "Nativefier apps have been installed"
echo "################################################################"
echo
tput sgr0

###############################################################################
