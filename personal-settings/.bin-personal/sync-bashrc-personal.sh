#!/bin/bash

# this provides 2-way sync of my .bashrc-personal file via insync and my Google Drive
# I use crontab to sync every 10s

rsync -avuP ~/.bashrc-personal /home/brett/Insync/brettcrisp2@gmail.com/'Google Drive'/.bashrc-personal
rsync -avuP /home/brett/Insync/brettcrisp2@gmail.com/'Google Drive'/.bashrc-personal ~/.bashrc-personal
