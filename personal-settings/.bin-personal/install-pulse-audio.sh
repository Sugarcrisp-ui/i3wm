#!/bin/bash
#set -e

sudo pacman -R --noconfirm gnome-bluetooth blueberry
sudo pacman -R --noconfirm pipewire-pulse
sudo pacman -R --noconfirm pipewire-alsa
sudo pacman -Rdd --noconfirm pipewire-jack
sudo pacman -R --noconfirm pipewire-media-session
sudo pacman -R --noconfirm pipewire-zeroconf
sudo pacman -Rdd --noconfirm pipewire

#sudo pacman -S --noconfirm --needed pipewire
#sudo pacman -S --noconfirm --needed pipewire-media-session
#sudo pacman -S --noconfirm --needed pipewire-alsa
#sudo pacman -Rdd --noconfirm jack2
#do pacman -S --noconfirm --needed pipewire-jack
#udo pacman -S --noconfirm --needed pipewire-zeroconf

sudo pacman -S --noconfirm --needed pulseaudio-alsa
sudo pacman -S --noconfirm --needed pulseaudio-bluetooth
sudo pacman -S --noconfirm --needed pulseaudio
sudo pacman -S --noconfirm --needed jack2

sudo pacman -S --noconfirm --needed gnome-bluetooth blueberry
sudo systemctl enable bluetooth.service

echo "Reboot now"