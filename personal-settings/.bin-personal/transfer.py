#!/usr/bin/env python3

import os
import readline

computers = {
    "desktop": "brett@192.168.1.10",
    "laptop": "brett@192.168.1.11",
    "kim": "192.168.1.12"
}

readline.set_completer_delims(' \t\n=')
readline.parse_and_bind("tab: complete")

file_location = input("Enter the file location: ")

# Check if file exists
if not os.path.exists(file_location):
    print("File does not exist. Please try again.")
    exit(1)

print("Select the destination computer:")
for i, comp in enumerate(computers.keys(), start=1):
    print(f"{i}. {comp}")
comp_choice = int(input("Enter your choice: "))

# Check if user's choice is valid
if comp_choice not in range(1, len(computers) + 1):
    print("Invalid choice. Please try again.")
    exit(1)

destination = list(computers.values())[comp_choice - 1]

destination_dir = input("Enter the destination directory: ")

# Perform the rsync
exit_status = os.system(f"rsync -avz --progress {file_location} {destination}:{destination_dir}")

# Check if rsync was successful
if exit_status != 0:
    print("Rsync failed. Please check your inputs and try again.")
else:
    print("Rsync completed successfully.")
