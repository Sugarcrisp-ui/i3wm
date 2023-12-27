#!/bin/bash

read -p "Enter the name for your web app: " app
read -p "Enter the website URL: " url

path="/home/brett/.local/share/applications/"
icon_path="/home/brett/Pictures/"

# Create a lowercase version of the app name
lower_app=$(echo "$app" | tr '[:upper:]' '[:lower:]')

# Create the .desktop file for Google Chrome
cat <<EOL >"$path${lower_app}_chrome.desktop"
[Desktop Entry]
Version=1.0
Terminal=false
Type=Application
Name=$app
Exec=google-chrome-stable --new-window $url --class=WebApp-${lower_app} --user-data-dir=/home/brett/.local/share/ice/profiles/${lower_app}
Icon=${icon_path}${lower_app}-icon.png
Categories=GTK;WebApps;
MimeType=text/html;text/xml;application/xhtml_xml;
StartupWMClass=WebApp-${lower_app}
StartupNotify=true
X-WebApp-Browser=Chrome
X-WebApp-URL=$url
X-WebApp-CustomParameters=
X-WebApp-Navbar=true
X-WebApp-PrivateWindow=false
X-WebApp-Isolated=true
EOL

echo "Web app '$app' for Chrome created successfully at $path${lower_app}_chrome.desktop"
