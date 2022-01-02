#!/bin/bash

# Directories

rsync -av --progress --delete /home/brett/.bin-personal/ /run/media/brett/7836d530-f67e-4d6b-a1ee-65e980d6dd45/.bin-personal

rsync -av --progress --delete --exclude=Insync/ --exclude=chromium/ /home/brett/.config/ /run/media/brett/7836d530-f67e-4d6b-a1ee-65e980d6dd45/.config

rsync -av --progress --delete --exclude=Trash/ /home/brett/.local/ /run/media/brett/7836d530-f67e-4d6b-a1ee-65e980d6dd45/.local

rsync -av --progress --delete /home/brett/.ssh/ /run/media/brett/7836d530-f67e-4d6b-a1ee-65e980d6dd45/.ssh

rsync -av --progress --delete /home/brett/.var/ /run/media/brett/7836d530-f67e-4d6b-a1ee-65e980d6dd45/.var

rsync -av --progress --delete /home/brett/.vnc/ /run/media/brett/7836d530-f67e-4d6b-a1ee-65e980d6dd45/.vnc

rsync -av --progress --delete /home/brett/Appimages/ /run/media/brett/7836d530-f67e-4d6b-a1ee-65e980d6dd45/Appimages

rsync -av --progress --delete /home/brett/Documents/ /run/media/brett/7836d530-f67e-4d6b-a1ee-65e980d6dd45/Documents

rsync -av --progress --delete /home/brett/Downloads/ /run/media/brett/7836d530-f67e-4d6b-a1ee-65e980d6dd45/Downloads

rsync -av --progress --delete /home/brett/Pictures/ /run/media/brett/7836d530-f67e-4d6b-a1ee-65e980d6dd45/Pictures

rsync -av --progress --delete /home/brett/Videos/ /run/media/brett/7836d530-f67e-4d6b-a1ee-65e980d6dd45/Videos

rsync -av --progress --delete /home/brett/"VirtualBox VMs"/ /run/media/brett/7836d530-f67e-4d6b-a1ee-65e980d6dd45/"VirtualBox VMs"

rsync -av --progress --delete /home/brett/Webapps/ /run/media/brett/7836d530-f67e-4d6b-a1ee-65e980d6dd45/Webapps



# files

rsync -av --progress --delete /home/brett/.bashrc-personal /run/media/brett/7836d530-f67e-4d6b-a1ee-65e980d6dd45/.bashrc-personal

