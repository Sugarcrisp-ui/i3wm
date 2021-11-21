#!/bin/bash
# The set command is used to determine action if error 
# is encountered.  (-e) will stop and exit (+e) will 
# continue with the script.
set +e

FIND='#PACKAGER="John Doe <john@doe.com>"'
REPLACE='PACKAGER="Brett Crisp <brettcrisp2@gmail.com>"'

find /etc/makepkg.conf -type f -exec sudo sed -i "s/$FIND/$REPLACE/g" {} \;

echo "################################################################"
echo "####                     makepkg corrected                ######"
echo "################################################################"
