#!/bin/bash

# The set command is used to determine action if error 
# is encountered.  (-e) will stop and exit (+e) will 
# continue with the script.
set -e

# Create .fonts directory if it doesn't exist
[ -d $HOME"/.fonts" ] || mkdir -p $HOME"/.fonts"

# Copy fonts to .fonts directory
echo "Copying fonts to .fonts directory..."
cp -Rf ~/i3wm/personal-settings/.fonts/* ~/.fonts/

# Rebuild font cache
echo "Building new fonts into the cache files..."
echo "Depending on the number of fonts, this may take a while..."
fc-cache -fv ~/.fonts

# Print message when script execution is complete
echo "################################################################"
echo "#########   Fonts have been copied and loaded   ################"
echo "################################################################"
