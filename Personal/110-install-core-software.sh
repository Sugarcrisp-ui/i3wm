#!/bin/bash
# The set command is used to determine action if error
# is encountered.  (-e) will stop and exit (+e) will
# continue with the script.
set +e
###############################################################################
# Author	:	Brett Crisp
###############################################################################

###############################################################################
#
#   DECLARATION OF FUNCTIONS
#
###############################################################################

func_install() {
	if pacman -Qi $1 &> /dev/null; then
		tput setaf 2
  		echo "###############################################################################"
  		echo "################## The package "$1" is already installed"
      	echo "###############################################################################"
      	echo
		tput sgr0
	else
    	tput setaf 3
    	echo "###############################################################################"
    	echo "##################  Installing package "  $1
    	echo "###############################################################################"
    	echo
    	tput sgr0
    	sudo pacman -S --noconfirm --needed $1
    fi
}

func_category() {
	tput setaf 5;
	echo "################################################################"
	echo "Installing software for category " $1
	echo "################################################################"
	echo;tput sgr0
}

###############################################################################

func_category Core Software

list=(
# Internet
#brave-bin
chromium
firefox
google-chrome
qtwebflix-git
speedtest-cli-git
rate-mirrors

# Multimedia
celluloid
ffmpeg
losslesscut-bin
openshot
qbittorrent
simplescreenrecorder
spotify
vlc

# Utilities
bitwarden
catfish
clipgrab
copyq
cronie
downgrade
etcher-bin
font-manager-git
gnome-calculator
gpick
grsync
grub-customizer
grub-hook
gthumb
gvfs
insync
inxi
meld
ranger
seahorse
sshfs
timeshift
timeshift-autosnap
unzip
wget
xfce4-appfinder
xfce4-notifyd
xfce4-power-manager
xfce4-screenshooter
xfce4-settings
xfce4-taskmanager
xfce4-terminal
zip

# Documents and Text
#atom
calibre
#geany
#gedit
libreoffice-still
micro
sublime-text-4
xournalpp
xreader

# Communication
arcolinux-teamviewer
caprine
discord
signal-desktop
whatsapp-nativefier

# Others
aic94xx-firmware
flatpak
grub-btrfs
pamac
paprefs
paru-bin
polybar
powerline
ttf-font-awesome
upd72020x-fw
wd719x-firmware

# Custom

# Developer
virtualbox

)

count=0
for name in "${list[@]}" ; do
	count=$[count+1]
	tput setaf 3;echo "Installing package nr.  "$count " " $name;tput sgr0;
	func_install $name
done

###############################################################################

tput setaf 11;
echo "################################################################"
echo "Software has been installed"
echo "################################################################"
echo;tput sgr0

###############################################################################
