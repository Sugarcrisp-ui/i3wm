#!/bin/bash

# Color definitions
GREEN=$(tput setaf 2)
BLUE=$(tput setaf 4)
CYAN=$(tput setaf 6)
RESET=$(tput sgr0)

echo "${BLUE}################################################################"
echo "                    Fixing Pamac AUR Integration"
echo "################################################################${RESET}"

# Backup original file
echo "${CYAN}Backing up community.xml.gz${RESET}"
sudo cp /usr/share/app-info/xmls/community.xml.gz "/usr/share/app-info/xmls/community.xml.gz.$(date +"%Y%m%d%H%M%S").bak"

# Remove problematic <em> tags
echo "${CYAN}Removing problematic tags${RESET}"
zcat /usr/share/app-info/xmls/community.xml.gz | sed 's|<em>||g;s|<\/em>||g;' | gzip > "/tmp/new.xml.gz"
sudo cp /tmp/new.xml.gz /usr/share/app-info/xmls/community.xml.gz

# Update and refresh appstream
echo "${CYAN}Updating appstream${RESET}"
sudo pacman -S appstream --noconfirm --needed
sudo appstreamcli refresh-cache --force --verbose

# Cleanup
echo "${CYAN}Cleaning up temporary files${RESET}"
rm -f /tmp/new.xml.gz

echo "${GREEN}################################################################"
echo "                    Pamac AUR Fix Complete!"
echo "################################################################${RESET}"