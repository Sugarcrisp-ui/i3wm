#!/bin/bash
# The set command is used to determine action if error 
# is encountered.  (-e) will stop and exit (+e) will 
# continue with the script.
set +e

[ -d $HOME"/.fonts" ] || mkdir -p $HOME"/.fonts"


echo "Copy fonts to .fonts"

installed_dir=$(dirname $(readlink -f $(basename `pwd`)))
cp $installed_dir/settings/fonts/* ~/.fonts/

echo "Building new fonts into the cache files";
echo "Depending on the number of fonts, this may take a while..."
fc-cache -fv ~/.fonts



echo "################################################################"
echo "#########   Fonts have been copied and loaded   ################"
echo "################################################################"
