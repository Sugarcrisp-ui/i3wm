function backup_file() {
    local source="$1"
    local dest="$2"
    log_message "CYAN" "Backing up $source"
    if ! sudo cp "$source" "$dest"; then
        log_message "RED" "Failed to backup $source"
        exit 1
    fi
}

function fix_community_xml() {
    log_message "CYAN" "Removing problematic tags"
    if ! zcat /usr/share/app-info/xmls/community.xml.gz | sed 's|<em>||g;s|<\/em>||g;' | gzip > "/tmp/new.xml.gz"; then
        log_message "RED" "Failed to modify community.xml.gz"
        exit 1
    fi
    if ! sudo cp /tmp/new.xml.gz /usr/share/app-info/xmls/community.xml.gz; then
        log_message "RED" "Failed to replace community.xml.gz"
        exit 1
    fi
}

function update_appstream() {
    log_message "CYAN" "Updating appstream"
    if ! sudo pacman -S appstream --noconfirm --needed &>/dev/null; then
        log_message "RED" "Failed to install appstream"
        exit 1
    fi
    if ! sudo appstreamcli refresh-cache --force --verbose; then
        log_message "RED" "Failed to refresh appstream cache"
        exit 1
    fi
}

function cleanup() {
    log_message "CYAN" "Cleaning up temporary files"
    rm -f /tmp/new.xml.gz || log_message "YELLOW" "Failed to remove temporary file - consider manual cleanup"
}