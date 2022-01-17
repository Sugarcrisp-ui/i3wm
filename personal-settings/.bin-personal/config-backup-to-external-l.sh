#!/bin/bash

# Directories

rsync -av --progress --delete /home/brett/.bin-personal/ /run/media/brett/7836d530-f67e-4d6b-a1ee-65e980d6dd45/laptop/.bin-personal

rsync -av --progress --delete --exclude=Insync/ --exclude=chromium/ /home/brett/.config/ /run/media/brett/7836d530-f67e-4d6b-a1ee-65e980d6dd45/laptop/.config

rsync -av --progress --delete --exclude=Trash/ /home/brett/.local/ /run/media/brett/7836d530-f67e-4d6b-a1ee-65e980d6dd45/laptop/.local

rsync -av --progress --delete /home/brett/.ssh/ /run/media/brett/7836d530-f67e-4d6b-a1ee-65e980d6dd45/laptop/.ssh

rsync -av --progress --delete /home/brett/.var/ /run/media/brett/7836d530-f67e-4d6b-a1ee-65e980d6dd45/laptop/.var

rsync -av --progress --delete /home/brett/.vnc/ /run/media/brett/7836d530-f67e-4d6b-a1ee-65e980d6dd45/laptop/.vnc

rsync -av --progress --delete /home/brett/Appimages/ /run/media/brett/7836d530-f67e-4d6b-a1ee-65e980d6dd45/laptop/Appimages

rsync -av --progress --delete /home/brett/Documents/ /run/media/brett/7836d530-f67e-4d6b-a1ee-65e980d6dd45/laptop/Documents

rsync -av --progress --delete /home/brett/Downloads/ /run/media/brett/7836d530-f67e-4d6b-a1ee-65e980d6dd45/laptop/Downloads

rsync -av --progress --delete /home/brett/Pictures/ /run/media/brett/7836d530-f67e-4d6b-a1ee-65e980d6dd45/laptop/Pictures

rsync -av --progress --delete /home/brett/Videos/ /run/media/brett/7836d530-f67e-4d6b-a1ee-65e980d6dd45/laptop/Videos

rsync -av --progress --delete /home/brett/"VirtualBox VMs"/ /run/media/brett/7836d530-f67e-4d6b-a1ee-65e980d6dd45/laptop/"VirtualBox VMs"

rsync -av --progress --delete /home/brett/Webapps/ /run/media/brett/7836d530-f67e-4d6b-a1ee-65e980d6dd45/laptop/Webapps



# files

rsync -av --progress --delete /home/brett/.bashrc-personal /run/media/brett/7836d530-f67e-4d6b-a1ee-65e980d6dd45/laptop/.bashrc-personal

rsync -av --progress --delete /usr/share/sddm/themes/arcolinux-sugar-candy/theme.conf /run/media/brett/7836d530-f67e-4d6b-a1ee-65e980d6dd45/laptop/themes

rsync -av --progress --delete /usr/share/sddm/themes/arcolinux-sugar-candy/Backgrounds/arco-login-plasma.jpg /run/media/brett/7836d530-f67e-4d6b-a1ee-65e980d6dd45/laptop/themes

rsync -av --progress --delete /usr/share/sddm/themes/arcolinux-sugar-candy/Backgrounds/bluez-7650x5120.jpg /run/media/brett/7836d530-f67e-4d6b-a1ee-65e980d6dd45/laptop/themes
