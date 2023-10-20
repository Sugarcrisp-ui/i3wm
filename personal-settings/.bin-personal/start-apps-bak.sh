#!/bin/bash

set -e

# Wait for 5 seconds before swithcing to workspace 2
sleep 5

# Switch to workspace 2
i3-msg workspace 2

# Start Thunar
#thunar &
/usr/sbin/thunar &

# Wait for 5 seconds before swithcing to workspace 3
sleep 5

# Switch to workspace 3
i3-msg workspace 3

# Start xfce4-terminal
#xfce4-terminal &
/usr/sbin/xfce4-terminal &

# Wait for xfce4-terminal to start
sleep 5

# Switch to workspace 4
i3-msg workspace 4

# Start Messenger
/home/brett/FacebookMessenger-linux-x64/FacebookMessenger &

# Wait for Messenger to start
sleep 5

# Start Whatsapp
/home/brett/Whatsapp-linux-x64/Whatsapp &

# Wait for Whatsapp to start
sleep 5

# Switch to workspace 5
i3-msg workspace 5

# Start Google Chrome
google-chrome-stable &

# Wait for Google Chrome to start
sleep 2

# Switch to workspace 1
i3-msg workspace 1
exit
