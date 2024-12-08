#!/usr/bin/env bash

# Author: Brett Crisp

declare -A colors=(
    [GREEN]="$(tput setaf 2)"
    [BLUE]="$(tput setaf 4)"
    [CYAN]="$(tput setaf 6)"
    [YELLOW]="$(tput setaf 3)"
    [RED]="$(tput setaf 1)"
    [RESET]="$(tput sgr0)"
)

function log_message() {
    local COLOR=${1}
    shift
    local MSG="${*}"
    echo -e "${colors[$COLOR]}${MSG}${RESET}"
}

function install_package() {
    if pacman -Qi "$1" &> /dev/null; then
        log_message "GREEN" "Already installed: $1"
    else
        log_message "CYAN" "Installing: $1"
        if ! pacman -S --noconfirm --needed "$1" &>/dev/null; then
            log_message "RED" "Failed to install: $1"
            return 1
        fi
    fi
    return 0
}

log_message "BLUE" "################################################################"
log_message "BLUE" "                    Setting Up Sound System"
log_message "BLUE" "################################################################"

# Sound packages
packages=(
    # Already installed pulseaudio-alsa
    # pavucontrol
    # alsa-firmware
    # Already installed alsa-lib
    # alsa-plugins
    # Already installed alsa-utils
    # gstreamer
    # gst-plugins-good
    # gst-plugins-bad
    # gst-plugins-base
    # gst-plugins-ugly
    pasystray
    # playerctl
    # Already installed volumeicon
)

# Install packages
log_message "CYAN" "Installing sound packages..."
failed_packages=()
for package in "${packages[@]}"; do
    [[ $package == \#* ]] && continue
    if ! install_package "$package"; then
        failed_packages+=("$package")
    fi
done

if [ ${#failed_packages[@]} -gt 0 ]; then
    log_message "RED" "The following sound packages failed to install:"
    for fail in "${failed_packages[@]}"; do
        log_message "RED" "- $fail"
    done
fi

# Setup PulseAudio
log_message "CYAN" "Setting up PulseAudio services..."
systemctl --user enable pulseaudio.service || log_message "RED" "Failed to enable PulseAudio service"
systemctl --user start pulseaudio.service || log_message "RED" "Failed to start PulseAudio service"

# Verify PulseAudio status
if systemctl --user is-active --quiet pulseaudio.service; then
    log_message "GREEN" "PulseAudio is running"
else
    log_message "RED" "PulseAudio start failed - check logs"
fi

log_message "GREEN" "################################################################"
log_message "GREEN" "                    Sound Setup Complete!"
log_message "GREEN" "################################################################"