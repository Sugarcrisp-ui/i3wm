#!/bin/bash

read -p "Enter the name for your web app: " app
read -p "Enter the website URL: " url

path="/home/brett/.local/share/applications/"
icon_path="/home/brett/Pictures/"

# Create a lowercase version of the app name
lower_app=$(echo "$app" | tr '[:upper:]' '[:lower:]')

# Create the .desktop file
cat <<EOL >"$path${lower_app}.desktop"
[Desktop Entry]
Version=1.0
Terminal=false
Type=Application
Name=$app
Exec=firefox --new-window $url
Icon=${icon_path}${lower_app}-icon.png
Categories=GTK;WebApps;
MimeType=text/html;text/xml;application/xhtml_xml;
StartupWMClass=WebApp-${lower_app}
StartupNotify=true
X-WebApp-Browser=Firefox
X-WebApp-URL=$url
X-WebApp-CustomParameters=
X-WebApp-Navbar=true
X-WebApp-PrivateWindow=false
X-WebApp-Isolated=true
EOL

echo "Web app '$app' created successfully at $path${lower_app}.desktop"
