#!/bin/bash
# The set command is used to determine action if error 
# is encountered.  (-e) will stop and exit (+e) will 
# continue with the script.
set +e
##################################################################################################################
tput setaf 3;echo "  DO NOT JUST RUN THIS. EXAMINE AND JUDGE. RUN AT YOUR OWN RISK."
echo "  THIS MAY BRICK YOUR SYSTEM"
echo "  BUT IT IS THE ONLY WAY TO GET RID OF ALL THESE PACKAGES";tput sgr0

sudo pacman -Rs arcolinux-meta-steam steam lib32-libvdpau lib32-libva lib32-nvidia-utils lib32-libxtst lib32-libxrandr lib32-libpulse lib32-gdk-pixbuf2 \
lib32-gtk2 lib32-openal lib32-mesa lib32-gcc-libs lib32-libx11 lib32-libxss lib32-alsa-plugins lsof lib32-libgpg-error \
lib32-libindicator-gtk2 lib32-libdbusmenu-glib lib32-libdbusmenu-gtk2 lib32-nss

# fixing what was broken after the uninstall
sudo pacman -S ttf-ms-fonts lsof --noconfirm
echo "################################################################"
echo "####                      packages uninstalled            ######"
echo "################################################################"
