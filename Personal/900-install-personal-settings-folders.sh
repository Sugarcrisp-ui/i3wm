#!/bin/bash
# The set command is used to determine action if error
# is encountered.  (-e) will stop and exit (+e) will
# continue with the script.
set -e
trap 'echo "An error occurred at line $LINENO. Exiting." >&2; exit 1' ERR

##################################################################################################################

tput setaf 11;
echo "################################################################"
echo "Creating private folders we use later"
echo ""
echo "################################################################"
tput sgr0

# ... [existing code for folder creation] ...

tput setaf 11;
echo "################################################################"
echo "Copying vconsole.conf to /etc/"
echo ""
echo "################################################################"
tput sgr0

# ... [existing code for vconsole.conf setup] ...

tput setaf 11;
echo "################################################################"
echo "Copying rc.local to /etc/"
echo ""
echo "################################################################"
tput sgr0

# ... [existing code for rc.local setup] ...

tput setaf 11;
echo "################################################################"
echo "Copying crontab"
echo ""
echo "################################################################"
tput sgr0

# ... [existing code for crontab setup] ...

# New section for setting up Polybar
tput setaf 11;
echo "################################################################"
echo "Setting up Polybar"
echo ""
echo "################################################################"
tput sgr0

# Ensure Polybar launch script is executable
if [ -f "$HOME/.config/polybar/launch.sh" ]; then
    chmod +x "$HOME/.config/polybar/launch.sh"
    echo "Made Polybar launch script executable."
else
    echo "Warning: Polybar launch script not found at $HOME/.config/polybar/launch.sh"
fi

echo "################################################################"
echo "folders created, files copied, permissions set, and Polybar configured"
echo "################################################################"