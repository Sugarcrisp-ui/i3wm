#!/bin/bash

# Run the expressvpn status command and capture the output
vpn_status=$(expressvpn status)

# Extract the VPN name from the output
vpn_name=$(echo "$vpn_status" | awk -F 'Connected to ' '{print $2}' | awk -F ' - ' '{print $1}')

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
    # Display the 2-letter code if a match is found
    echo "${vpn_location_codes[$vpn_name]}"
else
    # If no match is found, display the VPN name as is
    echo "$vpn_name"
fi
