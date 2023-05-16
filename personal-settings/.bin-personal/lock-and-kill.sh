#!/bin/bash

# Kill Insync
killall insync

# Lock Cryptomator
cryptomator lock

# Kill Cryptomator
killall cryptomator

#cd /home/brett/.local/share/Cryptomator/mnt
#fusermount3 -u Vault
rm -rf /home/brett/.local/share/Cryptomator/mnt/Vault
