import os

# Specify the directory path
directory = "/home/brett/Github/minti3/Personal"

# Change to the specified directory
os.chdir(directory)

# Desired order of file names
desired_order = [
    "a-remove-software.sh",
    "b-install-i3.sh",
    "c-install-personal-settings-folders.sh",
    "d-install-root-settings.sh",
    "e-gaps-install.sh",
    "f-install-core-software.sh",
    "g-insync.sh",
    "h-i3lock-fansy.sh",
    "i-laptop.sh",
    "j-fontawesome.sh",
    "k-install-picom.sh",
    "l-discord.sh",
    "m-vscode.sh",
    "n-realvnc.sh",
    "o-install-personal-settings-bookmarks.sh",
    "p-cryptomator-settings-for-thunar.sh",
    "q-install-settings-autoconnect-to-bluetooth-headset.sh",
    "r-software-flatpak.sh",
    "s-installing-fonts.sh",
    "t-autotiling.sh",
    "u-expressvpn.sh"
]

# List all files starting with a number
files = sorted([f for f in os.listdir() if f.endswith(".sh")])

# Dictionary to track changes
changes = {}

# Loop through the files
for i, desired_name in enumerate(desired_order):
    if i < len(files):
        # Store the change
        changes[files[i]] = desired_name

# Apply changes maintaining original order
for old_name, new_name in changes.items():
    os.rename(old_name, new_name)

print("Files have been adjusted successfully.")
