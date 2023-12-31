#!/bin/bash

sudo pacman -R --noconfirm blueberry
sudo pacman -R --noconfirm gnome-bluetooth
sudo pacman -R --noconfirm pulseaudio-alsa
sudo pacman -R --noconfirm pulseaudio-bluetooth
sudo pacman -Rdd --noconfirm jack2
sudo pacman -Rdd --noconfirm pulseaudio

sudo pacman -S --noconfirm --needed pipewire-jack
sudo pacman -S --noconfirm --needed pipewire
sudo pacman -S --noconfirm --needed lib32-pipewire
sudo pacman -S --noconfirm --needed wireplumber
sudo pacman -S --noconfirm --needed pipewire-pulse
sudo pacman -S --noconfirm --needed pipewire-alsa
sudo pacman -S --noconfirm --needed pipewire-zeroconf
sudo pacman -S --noconfirm --needed gnome-bluetooth
sudo pacman -S --noconfirm --needed blueberry

sudo systemctl enable bluetooth.service

echo "Reboot now"