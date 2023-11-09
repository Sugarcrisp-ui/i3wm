#!/bin/bash

# Run the expressvpn status command and capture the output
vpn_status=$(expressvpn status)

# Extract the VPN name from the output
vpn_name=$(echo "$vpn_status" | awk -F 'Connected to ' '{print $2}' | awk -F ' - ' '{print $1}')

# Check if the VPN is connected
if [ -n "$vpn_name" ]; then
    # Define a mapping of known VPN locations to 2-letter codes
    declare -A vpn_location_codes
    vpn_location_codes["San Francisco"]="SF"
    vpn_location_codes["Toronto"]="TO"
    vpn_location_codes["Singapore"]="SG"
    vpn_location_codes["Guam"]="GU"
    vpn_location_codes["Hong Kong"]="HK"
    vpn_location_codes["Japan"]="JP"
    vpn_location_codes["London"]="LN"
    vpn_location_codes["New York"]="NY"
    vpn_location_codes["Los Angeles"]="LA"
    vpn_location_codes["Vietnam"]="VN"
    # Add more locations as needed

    # Check if the extracted VPN name exists in the mapping
    if [ -n "${vpn_location_codes[$vpn_name]}" ]; then
        # Display the VPN status (green when connected) and the location with a hyphen
        echo "%{F#5be610} VPN%{U#5be610} - ${vpn_location_codes[$vpn_name]}"
    else
        # If no match is found, display the VPN status (red when disconnected) without the location
        echo "%{F#FF0000} VPN%{U#FF0000}"
    fi
else
    # Display "VPN" in red when disconnected
    echo "%{F#FF0000} VPN%{U#FF0000}"
fi
