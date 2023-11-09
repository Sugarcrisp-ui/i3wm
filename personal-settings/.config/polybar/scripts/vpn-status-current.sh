#!/bin/sh

VPN_INTERFACE="tun0"

if ifconfig -a | grep -q "${VPN_INTERFACE}"; then
  echo "%{F#5be610} VPN%{U#5be610}"
else
  echo "%{F#FF0000} VPN%{U#FF0000}"
fi
