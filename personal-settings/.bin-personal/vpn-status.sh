#!/bin/bash

# Define the Get function
function Get() {
  echo "$1"
}

# Define the Set function
function Set() {
  echo "$2" > "$1"
}

# Define the Store function
function Store() {
  local variables=()
  for variable in "${@:2}"; do
    variables+=("$1=$variable")
  done
  eval "${variables[@]}"
}

# Get the VPN status
vpn_status=$(Get "nmcli connection show | grep vpn | awk '{print $2}'")

# Set the image path based on the VPN status
if [[ "$vpn_status" == "active" ]]; then
  Set "$HOME/Pictures/lock-solid.svg" "image_path"
else
  Set "$HOME/Pictures/lock-open-solid.svg" "image_path"
fi

# Get the PID of the running Polybar process
polybar_pid=$(pidof polybar)

# Set the image in Polybar
polybar-msg -p "$polybar_pid" cmd set vpn-status image "$image_path"

# Hide and show the VPN status icon
Store polybar_msg_args -p "$polybar_pid" cmd hide vpn-status cmd show vpn-status

# Remove the image path from the polybar-msg arguments
unset polybar_msg_args[1]

# Call the polybar-msg command with the stored arguments
polybar-msg "${polybar_msg_args[@]}"
