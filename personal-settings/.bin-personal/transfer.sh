#!/bin/bash

# Define the list of computers
computers=("desktop" "laptop" "kim")

echo "Enter the file location:"
read -e file_location

# Check if file exists
if [[ ! -e "$file_location" ]]; then
    echo "File does not exist. Please try again."
    exit 1
fi

echo "Select the destination computer:"
select comp in "${computers[@]}"; do
    case $comp in
        "desktop")
            destination="brett@192.168.1.10"
            break
            ;;
        "laptop")
            destination="brett@192.168.1.11"
            break
            ;;
        "kim")
            destination="192.168.1.12"
            break
            ;;
        *) echo "Invalid option $REPLY";;
    esac
done

echo "Enter the destination directory:"
read -e destination_dir

# Perform the rsync
rsync -avz --progress "$file_location" "$destination:$destination_dir"

# Check if rsync was successful
if [[ $? -ne 0 ]]; then
    echo "Rsync failed. Please check your inputs and try again."
else
    echo "Rsync completed successfully."
fi
