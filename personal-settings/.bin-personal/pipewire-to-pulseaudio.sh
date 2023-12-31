#!/bin/bash

sudo pacman -R --noconfirm blueberry
sudo pacman -R --noconfirm gnome-bluetooth
sudo pacman -R --noconfirm pipewire-pulse
sudo pacman -R --noconfirm pipewire-alsa
sudo pacman -R --noconfirm pipewire-jack
sudo pacman -R --noconfirm wireplumber
sudo pacman -R --noconfirm pipewire-zeroconf
sudo pacman -R --noconfirm pipewire

sudo pacman -S --noconfirm --needed pulseaudio-alsa
sudo pacman -S --noconfirm --needed pulseaudio-bluetooth
sudo pacman -S --noconfirm --needed pulseaudio
sudo pacman -S --noconfirm --needed jack2
sudo pacman -S --noconfirm --needed gnome-bluetooth
sudo pacman -S --noconfirm --needed blueberry

sudo systemctl enable bluetooth.service

echo "Reboot now"