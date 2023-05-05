#!/bin/bash
# The set command is used to determine action if error
# is encountered.  (-e) will stop and exit (+e) will
# continue with the script.
set -e

personal_dir="$HOME/i3wm/personal-settings"

create_directories() {
    for dir in "$@"; do
        [ -d "$dir" ] || sudo mkdir -p "$dir"
    done
}

tput setaf 11;
echo "################################################################"
echo "Creating private folders we use later"
echo "################################################################"
tput sgr0

create_directories "$HOME/.bin" \
                   "$HOME/.fonts" \
                   "$HOME/.icons" \
                   "$HOME/.themes" \
                   "$HOME/.local/share/icons" \
                   "$HOME/.local/share/themes"

tput setaf 11;
echo "################################################################"
echo "Creating personal folders"
echo "################################################################"
tput sgr0

create_directories "$HOME/.bin-personal" \
                   "$HOME/.ssh" \
                   "$HOME/Appimages" \
                   "$HOME/Insync" \
                   "$ROOT/personal" \
                   "$ROOT/personal/.config" \
                   "$ROOT/var/spool/cron" \
                   "$ROOT/usr/share/sddm/themes/arcolinux-sugar-candy/Backgrounds"

tput setaf 11;
echo "################################################################"
echo "Copying .bin-personal"
echo "################################################################"
tput sgr0

sudo cp -Rf "$personal_dir/.bin-personal" ~

tput setaf 11;
echo "################################################################"
echo "Copying .config"
echo "################################################################"
tput sgr0

sudo cp -Rf "$personal_dir/.config" ~

tput setaf 11;
echo "################################################################"
echo "Copying .bashrc-personal"
echo "################################################################"
tput sgr0

cp "$personal_dir/.bashrc-personal" ~

tput setaf 11;
echo "################################################################"
echo "Copying sddm themes to /usr/share/themes"
echo "################################################################"
tput sgr0

sudo cp -Rf "$personal_dir/arcolinux-sugar-candy/theme.conf" /usr/share/sddm/themes/arcolinux-sugar-candy/
sudo cp -Rf "$personal_dir/arcolinux-sugar-candy/Backgrounds/arco-login-plasma.jpg" /usr/share/sddm/themes/arcolinux-sugar-candy/Backgrounds/

