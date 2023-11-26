#!/bin/bash

 Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar > /dev/null; do sleep 1; done

# Get the static hostname of the machine
HOSTNAME=$(hostnamectl --static)

# Check the hostname and launch the appropriate polybar configuration
if [ "$HOSTNAME" == "brett-ms7d82" ]; then
    polybar mainbar-i3-desktop
elif [ "$HOSTNAME" == "brett-k501ux" ]; then
    polybar mainbar-i3-laptop
else
    echo "Unknown hostname: $HOSTNAME"
fi
