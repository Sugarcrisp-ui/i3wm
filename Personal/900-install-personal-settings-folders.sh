#!/bin/bash
set -e
trap 'echo "An error occurred at line $LINENO. Exiting." >&2; exit 1' ERR

tput setaf 11;
echo "################################################################"
echo "Creating private folders we use later"
echo "################################################################"
tput sgr0

for dir in ".bin" ".icons" ".themes" ".local/share/icons" ".local/share/themes"; do
    [ -d "$HOME/$dir" ] || mkdir -p "$HOME/$dir"
done

tput setaf 11;
echo "################################################################"
echo "Creating personal folders"
echo "################################################################"
tput sgr0

for dir in "Appimages" "Calibre-Library" "Shared" "Trading"; do
    [ -d "$HOME/$dir" ] || mkdir -p "$HOME/$dir"
done

# Check if the directory should be created or if it's already a symlink from another script
if [ -d "$ROOT/var/spool/cron" ] || [ -L "$ROOT/var/spool/cron" ]; then
    echo "Skipping creation of $ROOT/var/spool/cron as it already exists or is symlinked."
else
    sudo mkdir -p "$ROOT/var/spool/cron"
fi

tput setaf 11;
echo "################################################################"
echo "Copying vconsole.conf to /etc/"
echo "################################################################"
tput sgr0

sudo cp /etc/vconsole.conf "/etc/vconsole.conf.$(date +"%Y%m%d%H%M%S").bak"
sudo rsync -avz --delete ~/i3wm/personal-settings/etc/vconsole.conf /etc/
sudo chown -R root:root /etc/vconsole.conf

tput setaf 11;
echo "################################################################"
echo "Copying rc.local to /etc/"
echo "################################################################"
tput sgr0

sudo cp /etc/rc.local "/etc/rc.local.$(date +"%Y%m%d%H%M%S").bak"
sudo rsync -avz --delete ~/i3wm/personal-settings/etc/rc.local /etc/
sudo chown -R root:root /etc/rc.local

tput setaf 11;
echo "################################################################"
echo "Copying crontab"
echo "################################################################"
tput sgr0

sudo chown -R root:root ~/i3wm/personal-settings/var/spool/cron/
sudo rsync -avz ~/i3wm/personal-settings/var/spool/cron/ /var/spool/cron

echo "################################################################"
echo "Folders created, files copied, and permissions set"
echo "################################################################"