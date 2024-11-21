#!/bin/bash
# The set command is used to determine action if error 
# is encountered.  (-e) will stop and exit (+e) will 
# continue with the script.
set +e
trap 'echo "Error on line $LINENO"; exit 1' ERR

# Fix to show icons and applications in pamac-aur
# Downgrading is another solution - see forum for that one

# Backup the original file
echo "Creating a backup of community.xml.gz..."
sudo cp /usr/share/app-info/xmls/community.xml.gz "/usr/share/app-info/xmls/community.xml.gz.$(date +"%Y%m%d%H%M%S").bak"

echo "Modifying community.xml.gz to remove <em> tags which can cause issues with Pamac..."
zcat /usr/share/app-info/xmls/community.xml.gz | sed 's|<em>||g;s|<\/em>||g;' | gzip > "/tmp/new.xml.gz"

echo "Copying modified file to system directory..."
sudo cp /tmp/new.xml.gz /usr/share/app-info/xmls/community.xml.gz

echo "Installing or updating appstream..."
sudo pacman -S appstream --noconfirm --needed

echo "Refreshing appstream cache to reflect changes..."
sudo appstreamcli refresh-cache --force --verbose

echo "Cleaning up temporary files..."
rm -f /tmp/new.xml.gz

echo "###############################################################################"
echo "###                               DONE                                     ####"
echo "###############################################################################"
