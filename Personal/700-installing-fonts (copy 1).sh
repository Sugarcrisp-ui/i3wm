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

func_category Fonts

list=(
arcolinux-fonts-git
awesome-terminal-fonts
adobe-source-sans-pro-fonts
ttf-bitstream-vera
ttf-droid
ttf-inconsolata
ttf-ubuntu-font-family
tamsyn-font
cantarell-fonts
noto-fonts
ttf-dejavu
ttf-droid
ttf-hack
ttf-liberation
ttf-roboto
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
