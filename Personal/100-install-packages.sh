#!/bin/bash

# Author: Brett Crisp
# Installs all packages (pacman, paru, flatpak)

# Color definitions
GREEN=$(tput setaf 2)
BLUE=$(tput setaf 4)
CYAN=$(tput setaf 6)
RESET=$(tput sgr0)

echo "${BLUE}################################################################"
echo "                    Installing Packages"
echo "################################################################${RESET}"

# Package categories
declare -A packages=(
    ["core"]="accountsservice aic94xx-firmware arandr archlinux-keyring archlinux-tools archlinux-wallpaper baobab bash-completion betterlockscreen bibata-cursor-theme bitwarden bluetooth-autoconnect chaotic-keyring cmake copyq cppdap cronie dconf-editor downgrade fd feh ffmpeg font-manager geany gendesk git github-desktop gnome-boxes gnome-calculator gnome-disk-utility gparted gpick gufw hardinfo hblock hw-probe i3lock-color libwnck3 libreoffice-still lua51 meld meson micro mintstick ninja paprefs pinta polybar potrace powerline python python-cairo python-distro python-gobject python-psutil python-tqdm qbittorrent qt5-graphicaleffects qt5-quickcontrols qt5-quickcontrols2 qt5-svg qt5ct qt6ct rate-mirrors realvnc-vnc-server realvnc-vnc-viewer ripgrep rofi rsync seahorse sshfs sublime-text-4 timeshift unace unrar unzip virtualbox virtualbox-host-dkms linux-headers vlc xclip yay zip"
    ["i3"]="i3-wm autotiling lxappearance feh picom rofi volumeicon"
    ["sound"]="pasystray"
    ["bluetooth"]="bluez bluez-libs bluez-utils blueman pulseaudio-bluetooth"
    ["aur"]="arc-gtk-theme kvantum-theme-arc rofi-themes-collection-git sofirem-git pamac-aur ttf-vista-fonts sardi-icons elementary-icon-theme brave-bin"
    ["flatpak"]="com.protonvpn.www"
    ["fonts"]="adobe-source-sans-pro-fonts awesome-terminal-fonts cantarell-fonts noto-fonts ttf-bitstream-vera ttf-inconsolata ttf-liberation ttf-opensans"
    ["remove"]="blueberry"
)

# Ensure cronie installs
echo "${CYAN}Ensuring cronie is installed...${RESET}"
pacman -Qi cronie &>/dev/null || sudo pacman -S --noconfirm cronie || echo "${YELLOW}Warning: Failed to install cronie${RESET}"

# Ensure flatpak installs
echo "${CYAN}Ensuring flatpak is installed...${RESET}"
pacman -Qi flatpak &>/dev/null || sudo pacman -S --noconfirm flatpak || echo "${YELLOW}Warning: Failed to install flatpak${RESET}"

# Install packages
for category in "${!packages[@]}"; do
    echo "${CYAN}Processing $category packages...${RESET}"
    if [ "$category" = "remove" ]; then
        for pkg in ${packages[$category]}; do
            pacman -Qi "$pkg" &>/dev/null && {
                echo "${CYAN}Removing: $pkg${RESET}"
                sudo pacman -Rs --noconfirm "$pkg"
            }
        done
    elif [ "$category" = "aur" ]; then
        paru -S --noconfirm --needed ${packages[$category]} || echo "${CYAN}Warning: Failed to install some AUR packages${RESET}"
    elif [ "$category" = "flatpak" ]; then
        if command -v flatpak &>/dev/null; then
            for pkg in ${packages[$category]}; do
                flatpak list | grep -q "$pkg" || {
                    echo "${CYAN}Installing: $pkg${RESET}"
                    flatpak install -y flathub "$pkg" || echo "${YELLOW}Warning: Failed to install $pkg${RESET}"
                }
            done
        else
            echo "${YELLOW}flatpak not installed, skipping flatpak packages${RESET}"
        fi
    else
        sudo pacman -S --noconfirm --needed ${packages[$category]} || echo "${CYAN}Warning: Failed to install some $category packages${RESET}"
    fi
done

# Finalize Thunar extensions
libtool --finish /usr/lib/thunarx-3 && echo "${GREEN}Finalized Thunar extensions${RESET}"

# Remove nouveau if no NVIDIA GPU
if ! lspci | grep -i nvidia &>/dev/null; then
    pacman -Qi xf86-video-nouveau &>/dev/null && {
        echo "${CYAN}Removing nouveau driver${RESET}"
        sudo pacman -Rs --noconfirm xf86-video-nouveau
    }
fi

echo "${GREEN}################################################################"
echo "                    Package Installation Complete!"
echo "################################################################${RESET}"
