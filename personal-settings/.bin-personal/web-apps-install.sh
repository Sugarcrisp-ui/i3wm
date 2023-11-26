#!/bin/bash

# Define the path where the .desktop files will be created
path="/home/brett/.local/share/applications/"

# Define the path where the icons are stored
icon_path="/home/brett/Pictures/"

# Define the list of web apps
declare -A web_apps
web_apps["Bard"]="https://bard.google.com/chat"
web_apps["Bitwarden"]="https://vault.bitwarden.com/#/login"
web_apps["ChatGPT"]="https://auth0.openai.com/u/login/identifier?state=hKFo2SBrclZ4WUJkQnhlZExKYS1zbjkwSDRlNi1ITThWM1lfdKFur3VuaXZlcnNhbC1sb2dpbqN0aWTZIDNWOUJWeTZETjVkMmFkYXNmVkZzcmlBLVRzVWdNNWdRo2NpZNkgVGRKSWNiZTE2V29USHROOTVueXl3aDVFNHlPbzZJdEc"
web_apps["Messenger"]="https://www.facebook.com/messages/t/5982819268494019/"
web_apps["Netflix"]="https://www.netflix.com/vn-en/Browse"
web_apps["Patreon"]="https://www.patreon.com/home"
web_apps["Whatsapp"]="https://web.whatsapp.com/"
web_apps["XTwitter"]="https://twitter.com/home?lang=en"
web_apps["Zalo"]="https://chat.zalo.me/"

# Loop through the web apps and create the .desktop files
for app in "${!web_apps[@]}"; do
    echo "[Desktop Entry]
    Version=1.0
    Terminal=false
    Type=Application
    Name=$app
    Exec=/usr/bin/google-chrome-stable --app=${web_apps[$app]}
    Icon=${icon_path}${app,,}-icon.png
    " > "${path}webapp-${app}.desktop"
done

# Make the .desktop files executable
chmod +x ${path}webapp-*.desktop
