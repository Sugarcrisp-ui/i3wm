#!/bin/bash
# The set command is used to determine action if error
# is encountered.  (-e) will stop and exit (+e) will
# continue with the script.
set -e

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
[ -d $HOME"/Github" ] || mkdir -p $HOME"/Github"
[ -d $HOME"/Insync" ] || mkdir -p $HOME"/Insync"
[ -d $ROOT"/personal" ]  || sudo mkdir -p $ROOT"/personal"
[ -d $ROOT"/personal/.config" ]  || sudo mkdir -p $ROOT"/personal/.config"
[ -d $ROOT"/var/spool/cron" ]  || sudo mkdir -p $ROOT"/var/spool/cron"
[ -d $ROOT"/usr/share/sddm/themes/arcolinux-sugar-candy/Backgrounds" ]  || sudo mkdir -p $ROOT"/usr/share/sddm/themes/arcolinux-sugar-candy/Backgrounds"

tput setaf 11;
echo "################################################################"
echo "Copying .bin-personal"
echo ""
echo "################################################################"
tput sgr0

cp -Rf ~/i3wm/personal-settings/.bin-personal ~

tput setaf 11;
echo "################################################################"
echo "Copying .config"
echo ""
echo "################################################################"
tput sgr0

cp -Rf ~/i3wm/personal-settings/.config ~

tput setaf 11;
echo "################################################################"
echo "Copying .local/share/applications/webapp files"
echo ""
echo "################################################################"
tput sgr0

cp -Rf ~/i3wm/personal-settings/.local ~

tput setaf 11;
echo "################################################################"
echo "Copying .vscode"
echo ""
echo "################################################################"
tput sgr0

cp -Rf ~/i3wm/personal-settings/.vscode ~

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

sudo cp -Rf ~/i3wm/personal-settings/arcolinux-sugar-candy/* /usr/share/sddm/themes/arcolinux-sugar-candy/

tput setaf 11;
echo "################################################################"
echo "Copying systemd files to /etc/systemd/system/"
echo ""
echo "################################################################"
tput sgr0

sudo chown -R root:root ~/i3wm/personal-settings/etc/

sudo rsync -avz --delete ~/i3wm/personal-settings/etc/systemd/system/* /etc/systemd/system/

tput setaf 11;
echo "################################################################"
echo "Copying systemd files to /etc/systemd/system/"
echo ""
echo "################################################################"
tput sgr0

# This makes the font size bigger in tty
sudo rsync -avz --delete ~/i3wm/personal-settings/etc/vconsole.conf /etc/

tput setaf 11;
echo "################################################################"
echo "Copying systemd files to /etc/systemd/system/"
echo ""
echo "################################################################"
tput sgr0

# This makes restores my rc.local settings
sudo rsync -avz --delete ~/i3wm/personal-settings/etc/rc.local /etc/

tput setaf 11;
echo "################################################################"
echo "Copying crontab"
echo ""
echo "################################################################"
tput sgr0

sudo chown -R root:root  ~/i3wm/personal-settings/var/spool/cron/root
sudo rsync -avz ~/i3wm/personal-setting/var/spool/cron/ /var/spool/cron

echo "################################################################"
echo "#########            folders created            ################"
echo "################################################################"
