#!/usr/bin/env bash

# Author: Brett Crisp
# Primary installation orchestrator script.

# Color definitions using associative array
declare -A colors=(
    [GREEN]="$(tput setaf 2)"
    [BLUE]="$(tput setaf 4)"
    [CYAN]="$(tput setaf 6)"
    [RED]="$(tput setaf 1)"
    [RESET]="$(tput sgr0)"
)

# Log file for tracking progress
LOG_FILE="/var/log/startup.log"
exec &> >(tee -a "$LOG_FILE")

# Print and log messages
function log_message() {
    local COLOR=${colors[$1]}
    shift
    local MSG="$*"
    echo -e "$(date '+%Y-%m-%d %H:%M:%S') ${COLOR}${MSG}${RESET}"
}

# Keep sudo alive
function keep_sudo_alive() {
    while true; do
        sudo -n true 2>/dev/null || sudo -v || exit 1
        sleep 60
    done &
    SUDO_PID=$!
    trap "kill $SUDO_PID" EXIT
}

# Run a script and log its status with error details
function run_script() {
    local script_name="$1"
    log_message "CYAN" "Executing: $script_name"
    if output=$(bash "$script_name" 2>&1); then
        log_message "GREEN" "Success: $script_name"
        return 0
    else
        log_message "RED" "Failed: $script_name - Error: $output"
        return 1
    fi
}

# Start
log_message "BLUE" "################################################################"
log_message "BLUE" "                    Starting Installation Script"
log_message "BLUE" "################################################################"

# Initiate sudo session
log_message "CYAN" "Initializing sudo session. Please enter your root password if prompted."
sudo -v || { log_message "RED" "Failed to obtain sudo privileges."; exit 1; }
keep_sudo_alive

# Configure parallel downloads
log_message "CYAN" "Configuring parallel downloads..."
if ! sudo sed -i 's/ParallelDownloads = 8/ParallelDownloads = 20/g; s/#ParallelDownloads = 5/ParallelDownloads = 20/g' /etc/pacman.conf; then
    log_message "RED" "Failed to configure parallel downloads."
    exit 1
fi

# System update
log_message "CYAN" "Updating system packages..."
if ! sudo pacman -Syyu --noconfirm; then
    log_message "RED" "System update failed."
    exit 1
fi

# Prepare scripts
log_message "CYAN" "Ensuring scripts are executable and navigating to Personal directory..."
if ! chmod +x Personal/*.sh || ! cd Personal; then
    log_message "RED" "Failed to prepare scripts or change directory."
    exit 1
fi

# Define and execute scripts
scripts=(
    "080-i3wm-install"
    "090-git-clone-dotfiles"
    "092-automount-remote-drive"
    "095-create-symlinks-from-dotfiles"
    "666-remove-software"
    # "105-install-arcolinux-software" # Clean arch install only
    "110-install-core-software"
    "115-warp-terminal-install"
    "120-sound"
    "160-laptop"
    "200-software-AUR-repo"
    "250-software-flatpak"
    "130-bluetooth"
    "260-enable-timeshift"
    "270-enable-hblock"
    "700-installing-fonts"
    "900-install-personal-settings-folders"
    # "905-install-personal-settings-bookmarks" # Currently using dotfiles
    "940-btrfs-setup"
    # "950-fix-pamac-aur" # May not be relevant anymore
)

log_message "CYAN" "Executing setup scripts..."

# Track script statuses
declare -A script_statuses

for script in "${scripts[@]}"; do
    script_path="${script}.sh"
    if [[ -f $script_path ]]; then
        run_script "$script_path"
        script_statuses["$script"]=$?
    else
        log_message "RED" "Script not found: $script_path"
        script_statuses["$script"]=1
    fi
done

# Enable core services
log_message "CYAN" "Enabling core services..."
if ! sudo systemctl enable cronie.service || ! sudo mkinitcpio -P; then
    log_message "RED" "Failed to enable core services."
    exit 1
fi

# Display summary
log_message "BLUE" "################################################################"
log_message "BLUE" "                    Installation Summary"
log_message "BLUE" "################################################################"

for script in "${!script_statuses[@]}"; do
    if [[ ${script_statuses[$script]} -eq 0 ]]; then
        log_message "GREEN" "Completed: $script"
    else
        log_message "RED" "Failed: $script"
    fi
done

log_message "GREEN" "################################################################"
log_message "GREEN" "                    Installation Complete!"
log_message "GREEN" "################################################################"