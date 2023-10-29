#!/bin/bash

# Run the expressvpn status command and capture the output
vpn_status=$(expressvpn status)

# Extract the VPN name from the output
vpn_name=$(echo "$vpn_status" | awk -F 'Connected to ' '{print $2}' | awk -F ' - ' '{print $1}')

# Output the VPN name
echo "$vpn_name"
