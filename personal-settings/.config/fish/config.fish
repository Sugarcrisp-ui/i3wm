if status is-interactive

    # PATH setting
    set -x PATH "$PATH:/opt/someApp/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:~/.bin-personal"

    # Commands to run in interactive sessions can go here
    alias update="paru -Syu; and flatpak update"

    # ExpressVPN
    alias es='expressvpn status'
    alias dis='expressvpn disconnect'
    
    function evpn
        expressvpn connect $argv
    end
    
    alias vn='evpn vn' # Vietnam
    alias gu='evpn gu' # Guam
    alias to='evpn cato' # Toronto
    alias hk1='evpn hk1' # Hong Kong 1
    alias sg='evpn sgju' # Singapore - Jurong
    alias jp='evpn jpto' # Japan - Tokyo
    alias lon='evpn uklo' # London
    alias la='evpn usla1' # Los Angeles 1
    alias sf='evpn ussf' # San Fransisco
    alias ko='evpn kr2' # South Korea 2
    alias ny='evpn usny' # New York 
    alias xv='evpn xv' # Pick for Me
    # Add other ExpressVPN aliases here
    
    # Micro editor
    alias mpacman='sudo micro /etc/pacman.conf'
    alias mmirrorlist='sudo micro /etc/pacman.d/mirrorlist'
    alias mbp='micro ~/.bashrc-personal'
    
    # Bash
    alias bashup='. ~/.bashrc'
    
    # Python
    alias transfer='python /home/brett/.bin-personal/transfer.py'
    alias backup='python ~/.bin-personal/file-backup-with-time.py'
    
    # Configuration backup
    alias topersonal='sudo /home/brett/.bin-personal/config-backup-to-personal.sh'
    alias togithub='config-backup-github.sh'
    alias toexternal='config-backup-to-external.sh'
    
    # System information
    alias sysinfo='inxi -Fxxxrz'
    
    # Bluetooth
    alias blue='bluetoothctl'
end
