#!/bin/bash

# Directories

rsync -av --progress --delete /home/brett/.bin-personal/ /run/media/brett/7836d530-f67e-4d6b-a1ee-65e980d6dd45/desktop/.bin-personal

rsync -av --progress --delete --exclude=Insync/ --exclude=chromium/ /home/brett/.config/ /run/media/brett/7836d530-f67e-4d6b-a1ee-65e980d6dd45/desktop/.config

rsync -av --progress --delete --exclude=Trash/ /home/brett/.local/ /run/media/brett/7836d530-f67e-4d6b-a1ee-65e980d6dd45/desktop/.local

rsync -av --progress --delete /home/brett/.ssh/ /run/media/brett/7836d530-f67e-4d6b-a1ee-65e980d6dd45/desktop/.ssh

rsync -av --progress --delete /home/brett/.var/ /run/media/brett/7836d530-f67e-4d6b-a1ee-65e980d6dd45/desktop/.var

rsync -av --progress --delete /home/brett/.vnc/ /run/media/brett/7836d530-f67e-4d6b-a1ee-65e980d6dd45/desktop/.vnc

rsync -av --progress --delete /home/brett/Appimages/ /run/media/brett/7836d530-f67e-4d6b-a1ee-65e980d6dd45/desktop/Appimages

rsync -av --progress --delete /home/brett/Documents/ /run/media/brett/7836d530-f67e-4d6b-a1ee-65e980d6dd45/desktop/Documents

rsync -av --progress --delete /home/brett/Downloads/ /run/media/brett/7836d530-f67e-4d6b-a1ee-65e980d6dd45/desktop/Downloads

rsync -av --progress --delete /home/brett/Pictures/ /run/media/brett/7836d530-f67e-4d6b-a1ee-65e980d6dd45/desktop/Pictures

rsync -av --progress --delete /home/brett/Videos/ /run/media/brett/7836d530-f67e-4d6b-a1ee-65e980d6dd45/desktop/Videos

rsync -av --progress --delete /home/brett/"VirtualBox VMs"/ /run/media/brett/7836d530-f67e-4d6b-a1ee-65e980d6dd45/desktop/"VirtualBox VMs"

rsync -av --progress --delete /home/brett/Webapps/ /run/media/brett/7836d530-f67e-4d6b-a1ee-65e980d6dd45/desktop/Webapps



# files

rsync -av --progress --delete /home/brett/.bashrc-personal /run/media/brett/7836d530-f67e-4d6b-a1ee-65e980d6dd45/desktop/.bashrc-personal

rsync -av --progress --delete /usr/share/sddm/themes/arcolinux-sugar-candy/theme.conf /run/media/brett/7836d530-f67e-4d6b-a1ee-65e980d6dd45/desktop/themes

rsync -av --progress --delete /usr/share/sddm/themes/arcolinux-sugar-candy/Backgrounds/arco-login-plasma.jpg /run/media/brett/7836d530-f67e-4d6b-a1ee-65e980d6dd45/desktop/themes

rsync -av --progress --delete /usr/share/sddm/themes/arcolinux-sugar-candy/Backgrounds/bluez-7650x5120.jpg /run/media/brett/7836d530-f67e-4d6b-a1ee-65e980d6dd45/desktop/themes

