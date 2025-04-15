#!/bin/bash

# Author: Brett Crisp
# Installs SDDM and themes

# Color definitions
GREEN=$(tput setaf 2)
CYAN=$(tput setaf 6)
BLUE=$(tput setaf 4)
RESET=$(tput sgr0)

echo "${CYAN}################################################################"
echo "                    Installing SDDM and Themes"
echo "################################################################${RESET}"

# Install dependencies
for dep in sddm qt5-svg qt5-declarative; do
    pacman -Qi "$dep" &>/dev/null || {
        echo "${CYAN}Installing: $dep${RESET}"
        sudo pacman -S --noconfirm "$dep" || echo "${BLUE}Warning: Failed to install $dep${RESET}"
    }
done

# Clone and install themes
mkdir -p ~/repos
cd ~/repos
if [ ! -d sddm-themes ]; then
    git clone https://github.com/Sugarcrisp-ui/sddm-themes.git || {
        echo "${BLUE}Failed to clone sddm-themes. Using default theme.${RESET}"
        SDDM_THEME="default"
    }
fi

if [ -d sddm-themes ]; then
    cd sddm-themes
    for theme in arcolinux-simplicity-theme.tar.gz arcolinux-sugar-candy-theme.tar.gz; do
        sudo mkdir -p /usr/share/sddm/themes
        sudo tar -xzf "$theme" -C /usr/share/sddm/themes/ || echo "${BLUE}Warning: Failed to install $theme${RESET}"
    done
    SDDM_THEME="arcolinux-simplicity"
else
    SDDM_THEME="default"
fi

# Configure SDDM
if [ "$SDDM_THEME" != "default" ] && [ -d "/usr/share/sddm/themes/$SDDM_THEME" ]; then
    echo "${CYAN}Configuring SDDM...${RESET}"
    SDDM_CONF_DIR="/etc/sddm.conf.d"
    SDDM_CONF_FILE="$SDDM_CONF_DIR/kde_settings.conf"
    sudo mkdir -p "$SDDM_CONF_DIR"
    [ -f "$SDDM_CONF_FILE" ] && sudo cp "$SDDM_CONF_FILE" "$SDDM_CONF_FILE.bak"
    sudo bash -c "cat > $SDDM_CONF_FILE" << EOF
[Autologin]
Relogin=false
Session=i3

[General]
HaltCommand=/usr/bin/systemctl poweroff
RebootCommand=/usr/bin/systemctl reboot

[Theme]
Current=$SDDM_THEME
CursorTheme=Bibata-Modern-Ice
Font=Noto Sans,10,-1,0,50,0,0,0,0,0

[Users]
MaximumUid=60513
MinimumUid=1000
EOF
else
    echo "${BLUE}Skipping SDDM configuration due to missing theme.${RESET}"
fi

echo "${GREEN}################################################################"
echo "                    SDDM Installation Complete!"
echo "################################################################${RESET}"
