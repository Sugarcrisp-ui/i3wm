#!/bin/bash

# Function to handle errors
handle_error() {
  echo -e "\e[31mAn error occurred. Please check the output and try again.\e[0m"
  exit 1
}

# Set up error handling
trap 'handle_error' ERR

# Function to install TimeShift and cronie
function install_timeshift_and_cronie() {
  # Install timeshift and cronie if not already installed
  if ! pacman -Qi timeshift &> /dev/null; then
    echo -e "\e[32mInstalling timeshift...\e[0m"
    sudo pacman -S --noconfirm timeshift
  else
    echo -e "\e[34mTimeshift is already installed. Skipping...\e[0m"
  fi

  if ! pacman -Qi cronie &> /dev/null; then
    echo -e "\e[32mInstalling cronie...\e[0m"
    sudo pacman -S --noconfirm cronie
  else
    echo -e "\e[34mCronie is already installed. Skipping...\e[0m"
  fi
}

# Enable and start cronie service
function enable_cronie_service() {
  echo -e "\e[32mEnabling and starting cronie service...\e[0m"
  sudo systemctl enable --now cronie.service
}

# Check if cronie is active
function check_cronie_status() {
  echo -e "\e[32mChecking cronie service status...\e[0m"
  systemctl status cronie.service
}

# Install Timeshift and Cronie, then start cronie service
install_timeshift_and_cronie
enable_cronie_service
check_cronie_status

# Success message
echo -e "\e[32mTimeshift and Cronie are set up and running!\e[0m"
