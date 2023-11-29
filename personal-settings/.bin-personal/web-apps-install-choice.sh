#!/bin/bash

path="/home/brett/.local/share/applications/test/"
icon_path="/home/brett/Pictures/"
declare -A web_apps=(
    ["Bard"]="https://bard.google.com/chat"
    ["Bitwarden"]="https://vault.bitwarden.com/#/login"
    ["ChatGPT"]="https://chat.openai.com/auth/login"
    ["Messenger"]="https://www.facebook.com/messages/t/5982819268494019/"
    ["Netflix"]="https://www.netflix.com/vn-en/Browse"
    ["Patreon"]="https://www.patreon.com/home"
    ["Whatsapp"]="https://web.whatsapp.com/"
    ["XTwitter"]="https://twitter.com/home?lang=en"
)

# Function to install webapps
install_webapps() {
    local install_browser="$1"
    for app in "${!web_apps[@]}"; do
        echo "[Desktop Entry]
            Version=1.0
            Terminal=false
            Type=Application
            Name=$app
            Exec=$install_browser --app=${web_apps[$app]} --class=WebApp-${app} --user-data-dir=/home/brett/.local/share/ice/profiles/${app}
            Icon=${icon_path}${app,,}-icon.png
            Categories=GTK;WebApps;
            MimeType=text/html;text/xml;application/xhtml_xml;
            StartupWMClass=WebApp-${app}
            StartupNotify=true
            X-WebApp-Browser=$install_browser
            X-WebApp-URL=${web_apps[$app]}
            X-WebApp-CustomParameters=
            X-WebApp-Navbar=false
            X-WebApp-PrivateWindow=false
            X-WebApp-Isolated=true" > "$path${app}.desktop"

        echo "$app - Installed with $install_browser"
    done
}

# Function to replace webapps
replace_webapps() {
    local replace_browser="$1"
    shift
    local app_list=("$@")
    for app in "${app_list[@]}"; do
        echo "$app to be replaced"
        if [ -e "$path${app}.desktop" ]; then
            rm -f "$path${app}.desktop"
            echo "$app - Deleted"
        fi

        echo "[Desktop Entry]
            Version=1.0
            Terminal=false
            Type=Application
            Name=$app
            Exec=$replace_browser --app=${web_apps[$app]} --class=WebApp-${app} --user-data-dir=/home/brett/.local/share/ice/profiles/${app}
            Icon=${icon_path}${app,,}-icon.png
            Categories=GTK;WebApps;
            MimeType=text/html;text/xml;application/xhtml_xml;
            StartupWMClass=WebApp-${app}
            StartupNotify=true
            X-WebApp-Browser=$replace_browser
            X-WebApp-URL=${web_apps[$app]}
            X-WebApp-CustomParameters=
            X-WebApp-Navbar=false
            X-WebApp-PrivateWindow=false
            X-WebApp-Isolated=true" > "$path${app}.desktop"

        echo "$app - Installed with $replace_browser"
    done
}

# Check if webapps are currently installed
if [ -z "$(ls -A $path)" ]; then
    echo "No webapps installed"
    echo "Install webapps using:"
    echo "1. Google Chrome"
    echo "2. Firefox"
    read -p "Enter your choice: " install_choice

    if [ "$install_choice" == "1" ]; then
        install_webapps "google-chrome-stable"
    elif [ "$install_choice" == "2" ]; then
        install_webapps "firefox"
    else
        echo "Invalid choice. Exiting."
        exit 1
    fi

else
    # List and replace webapps as before
    installed_apps=$(ls $path | sed 's/.desktop//g')

    if [ "$installed_apps" == "" ]; then
        echo "No webapps installed"
    else
        # List installed webapps
        echo "List of installed webapps:"
        count=1
        selected_apps=()
        for app in $installed_apps; do
            browser=$(grep -oP 'X-WebApp-Browser=\K[^ ]+' "$path$app.desktop")
            echo "$count. $app - Installed with $browser"
            selected_apps+=("$app")
            ((count++))
        done

        # Check if webapps need replacement
        echo "Replace webapps:"
        echo "1. All at once"
        echo "2. Selective apps"
        read -p "Enter your choice: " choice

        if [ "$choice" == "1" ]; then
            read -p "Replace all with 1. Google Chrome or 2. Firefox: " replace_choice
            if [ "$replace_choice" == "1" ]; then
                replace_webapps "google-chrome-stable" "${selected_apps[@]}"
            elif [ "$replace_choice" == "2" ]; then
                replace_webapps "firefox" "${selected_apps[@]}"
            else
                echo "Invalid choice. Exiting."
                exit 1
            fi
        elif [ "$choice" == "2" ]; then
            read -p "Enter the app numbers to replace (separated by spaces): " app_numbers
            selected_apps=()
            for app_number in $app_numbers; do
                selected_apps+=("${selected_apps[$((app_number - 1))]}")
            done

            read -p "Replace selected apps with 1. Google Chrome or 2. Firefox: " replace_choice

            if [ "$replace_choice" == "1" ]; then
                replace_webapps "google-chrome-stable" "${selected_apps[@]}"
            elif [ "$replace_choice" == "2" ]; then
                replace_webapps "firefox" "${selected_apps[@]}"
            else
                echo "Invalid choice. Exiting."
                exit 1
            fi
        else
            echo "Invalid choice. Exiting."
            exit 1
        fi
    fi
fi
