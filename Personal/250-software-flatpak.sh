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

func_install_flatpak() {
    if flatpak list | grep -q $1; then
        tput setaf 2
        echo "###############################################################################"
        echo "################## The Flatpak "$1" is already installed"
        echo "###############################################################################"
        echo
        tput sgr0
    else
        tput setaf 3
        echo "###############################################################################"
        echo "##################  Installing Flatpak "  $1
        echo "###############################################################################"
        echo
        tput sgr0
        flatpak install -y flathub $1
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

func_category Flatpaks

list=(
    net.nokyan.Resources
    flatpak install flathub com.github.PintaProject.Pinta
)

count=0
for name in "${list[@]}" ; do
    count=$[count+1]
    tput setaf 3;echo "Installing Flatpak nr.  "$count " " $name;tput sgr0;
    func_install_flatpak $name
done

###############################################################################

tput setaf 11;
echo "################################################################"
echo "Flatpaks have been installed"
echo "################################################################"
echo;tput sgr0

###############################################################################
