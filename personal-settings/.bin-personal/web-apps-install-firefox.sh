#!/bin/bash

# Define the path where the .desktop files will be created
path="/home/brett/.local/share/applications/"

# Define the path where the icons are stored
icon_path="/home/brett/Pictures/"

# Define the list of web apps
declare -A web_apps
web_apps["Bard"]="https://bard.google.com/chat"
web_apps["Bitwarden"]="https://vault.bitwarden.com/#/login"
web_apps["ChatGPT"]="https://chat.openai.com/auth/login"
web_apps["Messenger"]="https://www.facebook.com/messages/t/5982819268494019/"
web_apps["Netflix"]="https://www.netflix.com/vn-en/Browse"
web_apps["Patreon"]="https://www.patreon.com/home"
web_apps["Whatsapp"]="https://web.whatsapp.com/"
web_apps["XTwitter"]="https://twitter.com/home?lang=en"
#web_apps["Zalo"]="https://chat.zalo.me/"

# Check if web apps are already installed
installed=true
for app in "${!web_apps[@]}"; do
    if [ ! -f "${path}webapp-${app}.desktop" ]; then
        installed=false
        break
    fi
done

# Prompt to replace web apps if already installed
if [ "$installed" == true ]; then
    read -p "Web apps are already installed. Replace them? (y/n) " replace

    if [[ $replace =~ ^[Yy]$ ]]; then
        # Remove existing web apps
        rm "${path}webapp-"*.desktop

        # Install web apps again
        for app in "${!web_apps[@]}"; do
            echo "[Desktop Entry]
            Version=1.0
            Terminal=false
            Type=Application
            Name=$app
            Exec=firefox --new-window ${web_apps[$app]}
            Icon=${icon_path}${app,,}-icon.png
            Categories=GTK;WebApps;
            MimeType=text/html;text/xml;application/xhtml_xml;
            StartupWMClass=WebApp-${app}
            StartupNotify=true
            X-WebApp-Browser=Firefox
            X-WebApp-URL=${web_apps[$app]}
            X-WebApp-CustomParameters=
            X-WebApp-Navbar=false
            X-WebApp-PrivateWindow=false
            X-WebApp-Isolated=true
            " > "${path}webapp-${app}.desktop"
        done

        # Make the .desktop files executable
        chmod +x "${path}webapp-"*.desktop
        echo "Web apps have been replaced and installed using Firefox"
    else
        echo "No changes have been made. Web apps are currently installed."
    fi
else
    # Install web apps if not already installed
    for app in "${!web_apps[@]}"; do
        echo "[Desktop Entry]
        Version=1.0
        Terminal=false
        Type=Application
        Name=$app
        Exec=firefox --new-window ${web_apps[$app]}
        Icon=${icon_path}${app,,}-icon.png
        Categories=GTK;WebApps;
        MimeType=text/html;text/xml;application/xhtml_xml;
        StartupWMClass=WebApp-${app}
        StartupNotify=true
        X-WebApp-Browser=Firefox
        X-WebApp-URL=${web_apps[$app]}
        X-WebApp-CustomParameters=
        X-WebApp-Navbar=false
        X-WebApp-PrivateWindow=false
        X-WebApp-Isolated=true
        " > "${path}webapp-${app}.desktop"
    done

    # Make the .desktop files executable
    chmod +x "${path}webapp-"*.desktop
    echo "Web apps have been installed using Firefox"
fi
