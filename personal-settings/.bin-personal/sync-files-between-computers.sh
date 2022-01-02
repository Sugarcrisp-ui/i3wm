#!/bin/bash

# This is use to sync individual files as Insync can only be set up to handle directories.

# crontab is set up to run /.bin-personal/sync-files-between-computers.sh every 10s

# Sync .bashrc-personal
# requires 'bashup' or reboot to update the bash before changes take place

	# laptop brett
	rsync -av --progress --delete $HOME/.bashrc-personal brett@192.168.1.12:/home/brett/.bashrc-personal

	
	# laptop kim
	rsync -av --progress --delete $HOME/.bashrc-personal kim@192.168.1.13:/home/kim/.bashrc-personal
	

