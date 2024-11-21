#!/bin/bash

# Function to install a package if it's not already installed
install_package() {
  if ! pacman -Qs "$1" &> /dev/null; then
    echo -e "\e[32m###############################################################################\e[0m"
    echo -e "\e[32m################## Installing package $1\e[0m"
    echo -e "\e[32m###############################################################################\e[0m"
    echo
    sudo pacman -S --noconfirm --needed "$1"
  else
    echo -e "\e[32m###############################################################################\e[0m"
    echo -e "\e[32m################## The package $1 is already installed\e[0m"
    echo -e "\e[32m###############################################################################\e[0m"
    echo
  fi
}

# Function to check if the system is running on a laptop
is_laptop() {
  # This is a simple heuristic; might need adjustment based on your hardware
  # DMIDECODE is typically available on most systems and can identify if it's a laptop
  if dmidecode -t system | grep -qi 'laptop\|notebook'; then
    return 0
  else
    return 1
  fi
}

# Function to handle errors
handle_error() {
  echo -e "\e[31mAn error occurred while installing the packages. Please check the output and try again.\e[0m"
  exit 1
}

# Set up error handling
trap 'handle_error' ERR

# Check if the system is a laptop before proceeding
if is_laptop; then
  # Install TLP
  install_package "tlp"
  
  # Enable TLP service
  sudo systemctl enable tlp.service
  
  # Check if TLP was enabled successfully
  if systemctl is-enabled tlp.service &>/dev/null; then
    echo -e "\e[32mTLP service has been enabled.\e[0m"
  else
    echo -e "\e[31mFailed to enable TLP service. Please enable it manually.\e[0m"
  fi
else
  echo -e "\e[33mThis system does not appear to be a laptop. Skipping TLP installation.\e[0m"
fi

# Final message
echo -e "\e[32m################################################################\e[0m"
echo -e "\e[32m################## Laptop software has been processed\e[0m"
echo -e "\e[32m################################################################\e[0m"
echo
