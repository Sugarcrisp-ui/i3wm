#!/usr/bin/env bash

# Author: Brett Crisp

declare -A colors=(
    [GREEN]="$(tput setaf 2)"
    [BLUE]="$(tput setaf 4)"
    [CYAN]="$(tput setaf 6)"
    [RESET]="$(tput sgr0)"
)

function log_message() {
    local COLOR=${1}
    shift
    local MSG="${*}"
    echo -e "${colors[$COLOR]}${MSG}${RESET}"
}

function is_installed() {
    pacman -Qi "$1" &> /dev/null
}

function install_package() {
    if ! is_installed "$1"; then
        log_message "CYAN" "Installing: $1"
        if ! pacman -S --noconfirm --needed "$1" &>/dev/null; then
            log_message "RED" "Failed to install: $1"
            return 1
        fi
    else
        log_message "GREEN" "Already installed: $1"
    fi
    return 0
}

# Print header
log_message "BLUE" "################################################################"
log_message "BLUE" "                Installing Core Software Packages"
log_message "BLUE" "################################################################"

# Core software packages
packages=(
    # arcolinux-teamviewer
    bitwarden
    baobab
    brave-bin
    # grub-btrfs
    copyq
    cronie
    fd
    ffmpeg
    flatpak
    geany
    github-desktop-bin
    gnome-calculator
    gpick
    gufw
    insync
    libreoffice-still
    meld
    micro
    pamac-aur
    paprefs
    pinta
    polybar
    potrace
    powerline
    qbittorrent
    qt5-graphicaleffects
    qt5-svg
    qt6ct
    realvnc-vnc-server
    realvnc-vnc-viewer
    ripgrep
    seahorse
    # simplescreenrecorder
    spotify
    sshfs
    # stow # Not needed, using create-symlink.sh instead
    timeshift
    # Used with btrfs timeshift-autosnap
    virtualbox
    visual-studio-code-bin
    vlc
    webapp-manager
    xclip
    zip
)

# Install packages
log_message "CYAN" "Installing core software..."
total=${#packages[@]}
current=0
failed_packages=()

for package in "${packages[@]}"; do
    [[ $package == \#* ]] && continue
    ((current++))
    log_message "BLUE" "[${current}/${total}] Processing package: ${package}"
    if ! install_package "$package"; then
        failed_packages+=("$package")
    fi
done

if [ ${#failed_packages[@]} -gt 0 ]; then
    log_message "RED" "The following packages failed to install:"
    for fail in "${failed_packages[@]}"; do
        log_message "RED" "- $fail"
    done
else
    log_message "GREEN" "All packages installed successfully."
fi

log_message "GREEN" "################################################################"
log_message "GREEN" "                Core Software Installation Complete!"
log_message "GREEN" "################################################################"