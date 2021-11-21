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
atom
bitwarden
blueman
calibre
catfish
celluloid
chromium
clipgrab
clipman
cronie
discord
etcher-bin
firefox
flatpak
font-manager-git
geany
gedit
gnome-calculator
gpick
grsync
grub-btrfs
insync
#libreoffice-fresh
libreoffice-still
meld
micro
openshot
pamac
paprefs
powerline
qbittorrent
ranger
seahorse
simplescreenrecorder
speedtest-cli-git
spotify
sublime-text-4
syncthing
timeshift
timeshift-autosnap
#tlp
ttf-font-awesome
virtualbox
xfce4-appfinder
#xfce4-terminal
xournalpp
xreader
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
