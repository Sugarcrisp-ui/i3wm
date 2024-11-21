#!/bin/bash
# The set command is used to determine action if error
# is encountered.  (-e) will stop and exit (+e) will
# continue with the script.
set -e
trap 'echo "An error occurred at line $LINENO. Exiting." >&2; exit 1' ERR

##################################################################################################################

tput setaf 11;
echo "################################################################"
echo "Creating private folders we use later"
echo ""
echo "################################################################"
tput sgr0

[ -d $HOME"/.bin" ] || mkdir -p $HOME"/.bin"
[ -d $HOME"/.fonts" ] || mkdir -p $HOME"/.fonts"
[ -d $HOME"/.icons" ] || mkdir -p $HOME"/.icons"
[ -d $HOME"/.themes" ] || mkdir -p $HOME"/.themes"
[ -d $HOME"/.local/share/icons" ] || mkdir -p $HOME"/.local/share/icons"
[ -d $HOME"/.local/share/themes" ] || mkdir -p $HOME"/.local/share/themes"

tput setaf 11;
echo "################################################################"
echo "Creating personal folders"
echo ""
echo "################################################################"
tput sgr0

[ -d $HOME"/.bin-personal" ] || mkdir -p $HOME"/.bin-personal"
[ -d $HOME"/.ssh" ] || mkdir -p $HOME"/.ssh"
[ -d $HOME"/Appimages" ] || mkdir -p $HOME"/Appimages"
[ -d $HOME"/Calibre-Library" ] || mkdir -p $HOME"/Calibre-Library"
[ -d $HOME"/Shared" ] || mkdir -p $HOME"/Shared"
[ -d $HOME"/Trading" ] || mkdir -p $HOME"/Trading"
[ -d $HOME"/bashrc-personal" ] || mkdir -p $HOME"/bashrc-personal"
[ -d $HOME"/Insync" ] || mkdir -p $HOME"/Insync"
[ -d $ROOT"/var/spool/cron" ]  || sudo mkdir -p $ROOT"/var/spool/cron"

#tput setaf 11;
#echo "################################################################"
#echo "Copying .bin-personal"
#echo ""
#echo "################################################################"
#tput sgr0

#cp -Rf ~/i3wm/personal-settings/.bin-personal ~

tput setaf 11;
echo "################################################################"
echo "Copying .config"
echo ""
echo "################################################################"
tput sgr0

cp -Rf ~/i3wm/personal-settings/.config ~

tput setaf 11;
echo "################################################################"
echo "Copying .local/share/applications/.desktop files"
echo ""
echo "################################################################"
tput sgr0

# Create the directory if it doesn't exist
mkdir -p ~/.local/share/applications

# Copy .desktop files from repo to user's local directory
cp -Rf ~/i3wm/personal-settings/.local/share/applications/*.desktop ~/.local/share/applications/

# Make .desktop files executable
chmod +x ~/.local/share/applications/*.desktop

# Update desktop database to reflect changes
update-desktop-database ~/.local/share/applications

tput setaf 11;
echo "################################################################"
echo "Copying .bashrc-personal"
echo ""
echo "################################################################"
tput sgr0

cp ~/i3wm/personal-settings/.bashrc-personal ~

tput setaf 11;
echo "################################################################"
echo "Copying sddm themes to /usr/share/themes"
echo ""
echo "################################################################"
tput sgr0

# Ensure the theme directory exists
sudo mkdir -p /usr/share/sddm/themes/arcolinux-sugar-candy

# Copy the entire directory
sudo cp -Rf ~/i3wm/personal-settings/arcolinux-sugar-candy/* /usr/share/sddm/themes/arcolinux-sugar-candy/

# Set correct permissions
sudo chown -R root:root /usr/share/sddm/themes/arcolinux-sugar-candy/
sudo chmod -R 755 /usr/share/sddm/themes/arcolinux-sugar-candy/

#tput setaf 11;
#echo "################################################################"
#echo "Copying systemd files to /etc/systemd/system/"
#echo ""
#echo "################################################################"
#tput sgr0

#sudo chown -R root:root ~/i3wm/personal-settings/etc/

#sudo rsync -avz --delete ~/i3wm/personal-settings/etc/systemd/system/* /etc/systemd/system/

tput setaf 11;
echo "################################################################"
echo "Copying vconsole.conf to /etc/"
echo ""
echo "################################################################"
tput sgr0

sudo cp /etc/vconsole.conf "/etc/vconsole.conf.$(date +"%Y%m%d%H%M%S").bak"

# This makes the font size bigger in tty
sudo rsync -avz --delete ~/i3wm/personal-settings/etc/vconsole.conf /etc/

sudo chown -R root:root /etc/vconsole.conf

tput setaf 11;
echo "################################################################"
echo "Copying rc.local to /etc/"
echo ""
echo "################################################################"
tput sgr0

sudo cp /etc/rc.local "/etc/rc.local.$(date +"%Y%m%d%H%M%S").bak"

# This restores my rc.local settings
sudo rsync -avz --delete ~/i3wm/personal-settings/etc/rc.local /etc/

sudo chown -R root:root /etc/rc.local

tput setaf 11;
echo "################################################################"
echo "Copying crontab"
echo ""
echo "################################################################"
tput sgr0

# Ensure correct permissions for cron files
sudo chown -R root:root  ~/i3wm/personal-settings/var/spool/cron/
sudo rsync -avz ~/i3wm/personal-settings/var/spool/cron/ /var/spool/cron

echo "################################################################"
echo "folders created, files copied, and permissions set"
echo "################################################################"
