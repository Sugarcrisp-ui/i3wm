#!/bin/bash
# The set command is used to determine action if error 
# is encountered.  (-e) will stop and exit (+e) will 
# continue with the script.
set +e

# https://aur.archlinux.org/packages/pamac-aur/

echo "Fix to show icons and applications in pamac-aur"
echo "Downgrading is another solution - see forum for that one"

zcat /usr/share/app-info/xmls/community.xml.gz | sed 's|<em>||g;s|<\/em>||g;' | gzip > "/tmp/new.xml.gz"
sudo cp /tmp/new.xml.gz /usr/share/app-info/xmls/community.xml.gz
sudo pacman -S appstream --noconfirm --needed
sudo appstreamcli refresh-cache --force

echo "###############################################################################"
echo "###                               DONE                                     ####"
echo "###############################################################################"
