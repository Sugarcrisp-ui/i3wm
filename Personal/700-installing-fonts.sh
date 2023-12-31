#!/bin/bash

# The set command is used to determine action if error 
# is encountered. (-e) will stop and exit, (+e) will 
# continue with the script.
set -e

###############################################################################
#
#   DECLARATION OF FUNCTIONS
#
###############################################################################

# Install a package, if not already installed
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
	echo "Installing fonts " $1
	echo "################################################################"
	echo;tput sgr0
}

###############################################################################

func_category Fonts

list=(
arcolinux-fonts-git
adobe-source-sans-pro-fonts
awesome-terminal-fonts
cantarell-fonts
noto-fonts
ttf-bitstream-vera
ttf-dejavu
ttf-droid
ttf-font-awesome
ttf-font-awesome-5
ttf-font-awesome-6
ttf-hack
ttf-inconsolata
ttf-liberation
ttf-ms-fonts
ttf-opensans
ttf-roboto
ttf-roboto-mono
ttf-ubuntu-font-family
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
