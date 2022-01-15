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
[ -d $HOME"/Insync" ] || mkdir -p $HOME"/Insync"
[ -d $ROOT"/personal" ]  || sudo mkdir -p $ROOT"/personal"
[ -d $ROOT"/personal/.config" ]  || sudo mkdir -p $ROOT"/personal/.config"
#[ -d $ROOT"/personal/.local" ]  || sudo mkdir -p $ROOT"/personal/.local"
#[ -d $ROOT"/personal/.config/variety" ]  || sudo mkdir -p $ROOT"/personal/.config/variety"
#[ -d $ROOT"/personal/.local/share/ice" ]  || sudo mkdir -p $ROOT"/personal/.local/share/ice"
[ -d $ROOT"/var/spool/cron" ]  || sudo mkdir -p $ROOT"/var/spool/cron"


tput setaf 11;
echo "################################################################"
echo "Copying .bin-personal"
echo ""
echo "################################################################"
tput sgr0

cp -Rf ~/i3wm/personal-settings/.bin-personal ~/bin-personal
#cp -Rf /run/media/brett/7836d530-f67e-4d6b-a1ee-65e980d6dd45/desktop/.bin-personal ~
#cp -Rf /run/media/brett/7836d530-f67e-4d6b-a1ee-65e980d6dd45/laptop/.bin-personal ~

tput setaf 11;
echo "################################################################"
echo "Copying .config"
echo ""
echo "################################################################"
tput sgr0

cp -Rf ~/i3wm/personal-settings/.config ~.config
#cp -Rf /run/media/brett/7836d530-f67e-4d6b-a1ee-65e980d6dd45/desktop/.config ~
#cp -Rf /run/media/brett/7836d530-f67e-4d6b-a1ee-65e980d6dd45/laptop/.config ~

tput setaf 11;
echo "################################################################"
echo "Copying .bashrc-personal"
echo ""
echo "################################################################"
tput sgr0

cp ~/i3wm/personal-settings/.bashrc-personal ~
#cp -Rf /run/media/brett/7836d530-f67e-4d6b-a1ee-65e980d6dd45/desktop/.bashrc-personal ~
#cp -Rf /run/media/brett/7836d530-f67e-4d6b-a1ee-65e980d6dd45/laptop/.bashrc-personal ~

tput setaf 11;
echo "################################################################"
echo "Copying arcolinux-welcome-app"
echo ""
echo "################################################################"
tput sgr0

cp ~/i3wm/personal-settings/arcolinux-welcome-app/ ~/arcolinux-welcome-app
#cp -Rf /run/media/brett/7836d530-f67e-4d6b-a1ee-65e980d6dd45/desktop/arcolinux-welcome-app/ ~
#cp -Rf /run/media/brett/7836d530-f67e-4d6b-a1ee-65e980d6dd45/laptop/arcolinux-welcome-app/ ~

tput setaf 11;
echo "################################################################"
echo "Copying sddm themes to /usr/share/themes"
echo ""
echo "################################################################"
tput sgr0

sudo cp ~/i3wm/arcolinux-sugar-candy/theme.conf /usr/share/sddm/themes/arcolinux-sugar-candy/
#sudo cp -Rf /run/media/brett/7836d530-f67e-4d6b-a1ee-65e980d6dd45/desktop/themes/theme.conf /usr/share/sddm/themes/arcolinux-sugar-candy/
#sudo cp -Rf /run/media/brett/7836d530-f67e-4d6b-a1ee-65e980d6dd45/laptop/themes/theme.conf /usr/share/sddm/themes/arcolinux-sugar-candy/

sudo cp ~/i3wm/arcolinux-sugar-candy/Backgrounds/arco-login-plasma.jpg /usr/share/sddm/themes/arcolinux-sugar-candy/Backgrounds/
#sudo cp -Rf /run/media/brett/7836d530-f67e-4d6b-a1ee-65e980d6dd45/desktop/themes/arco-login-plasma.jpg /usr/share/sddm/themes/arcolinux-sugar-candy/Backgrounds/
#sudo cp -Rf /run/media/brett/7836d530-f67e-4d6b-a1ee-65e980d6dd45/laptop/themes/arco-login-plasma.jpg /usr/share/sddm/themes/arcolinux-sugar-candy/Backgrounds/

sudo cp ~/i3wm/arcolinux-sugar-candy/Backgrounds/bluez-7650x5120.jpg /usr/share/sddm/themes/arcolinux-sugar-candy/Backgrounds/
#sudo cp -Rf /run/media/brett/7836d530-f67e-4d6b-a1ee-65e980d6dd45/desktop/themes/bluez-7650x5120.jpg /usr/share/sddm/themes/arcolinux-sugar-candy/Backgrounds/
#sudo cp -Rf /run/media/brett/7836d530-f67e-4d6b-a1ee-65e980d6dd45/laptop/themes/bluez-7650x5120.jpg /usr/share/sddm/themes/arcolinux-sugar-candy/Backgrounds/

tput setaf 11;
echo "################################################################"
echo "Copying crontab"
echo ""
echo "################################################################"
tput sgr0

cd ~/i3wm/cron

# Change the root cron onwership to root:root
sudo chown root:root root

sudo cp -Rf ~/i3wm/cron/* /var/spool/cron/

echo "################################################################"
echo "#########            folders created            ################"
echo "################################################################"
