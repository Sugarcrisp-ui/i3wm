#!/bin/bash

# Run the expressvpn status command and capture the output
vpn_status=$(expressvpn status)

# Extract the VPN name from the output
vpn_name=$(echo "$vpn_status" | awk -F 'Connected to ' '{print $2}' | sed -E -e 's/ - [0-9]+$//')

# Check if the VPN is connected
if [ -n "$vpn_name" ]; then
    # Define a mapping of known VPN locations to 2-letter codes
    declare -A vpn_location_codes
    vpn_location_codes["Vietnam"]="VN"
    vpn_location_codes["USA - Los Angeles"]="LA"
    vpn_location_codes["USA - San Francisco"]="SF"
    vpn_location_codes["Canada - Toronto"]="TO"
    vpn_location_codes["Singapore - Jurong"]="SG"
    vpn_location_codes["Guam"]="GU"
    vpn_location_codes["Hong Kong"]="HK"
    vpn_location_codes["Japan - Tokyo"]="JP"
    vpn_location_codes["UK - London"]="LN"
    vpn_location_codes["South Korea"]="SK"
    vpn_location_codes["USA - New York"]="NY"

    # Check if the extracted VPN name exists in the mapping
    if [ -n "${vpn_location_codes[$vpn_name]}" ]; then
        # Display the VPN status (green when connected) and the location with a hyphen
        location_code="${vpn_location_codes[$vpn_name]}"
        echo "%{F#5be610} VPN%{U#5be610} - ${location_code}"
    else
        # If the location is not in the predefined list, display only the connected status (green)
        echo "%{F#5be610} VPN%{U#5be610} - Connected"
    fi
else
    # Display "VPN" in red when disconnected
    echo "%{F#FF0000} VPN%{U#FF0000}"
fi
