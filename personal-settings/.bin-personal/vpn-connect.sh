#!/bin/bash

# vpn connection is delayed to allow wired connection to be established first
# The following is added to i3wm config
#exec --no-startup-id sh -c "sleep 3 && /home/brett/.bin-personal/vpn-connect.sh" 

nmcli connection up my_expressvpn_vietnam_udp
