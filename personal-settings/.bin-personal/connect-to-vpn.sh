#!/bin/bash

# I use cron or systemd to run this script after boot up to 
# to start the vpn
	/usr/bin/nmcli connection up my_expressvpn_vietnam_udp
		 
