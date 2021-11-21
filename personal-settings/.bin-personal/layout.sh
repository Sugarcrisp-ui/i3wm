#!/bin/bash

# Switch to Workspace 1
wmctrl -s 1 

# Open Ranger File Manager
xfce4-terminal -e "bash -c 'ranger; exec bash'" --fullscreen

sleep 0.2

# Switch to Workspace 2
wmctrl -s 2

# Open Terminal
exo-open --launch TerminalEmulator --fullscreen

sleep 0.4

# Switch to Desktop 0
wmctrl -s 0

# Open Browser
exo-open --launch WebBrowser --fullscreen