#!/bin/bash

# Ask for the directory containing the image files
echo "Enter the directory containing the image files:"
read -e image_dir

# Convert the provided path to an absolute path
image_dir=$(eval readlink -f "$image_dir" 2>/dev/null || echo "$PWD/$image_dir")

# List the image files and allow the user to select one
images=($(find "$image_dir" -maxdepth 1 -type f -iregex '.*\.\(png\|jpg\|bmp\|gif\|svg\)' -exec basename {} \; | sed 's/ /-/g' | sort))
if [ ${#images[@]} -eq 0 ]; then
    echo "No image files found in the specified directory."
    exit 1
fi

echo "Image files:"
for i in "${!images[@]}"; do
    echo "$((i+1)): ${images[$i]}"
done
echo "Enter the number of the image file to convert:"
read image_num
image_file="${images[$((image_num-1))]}"

# List the formats and allow the user to select one
formats=("png" "jpg" "bmp" "gif" "svg")
echo "Formats:"
for i in "${!formats[@]}"; do
    echo "$((i+1)): ${formats[$i]}"
done
echo "Enter the number of the image format to convert to:"
read format_num
format_to="${formats[$((format_num-1))]}"

# Convert the image using ImageMagick
converted_file="$(basename "$image_file" .jpg).$format_to"

# Check if the file already exists in the destination directory
destination="$image_dir/"
if [ -e "$destination/$converted_file" ]; then
    read -p "File already exists. Do you want to overwrite it? (yes/no): " overwrite
    if [ "$overwrite" != "yes" ]; then
        read -p "Enter a new name for the file: " new_name
        converted_file="$new_name.$format_to"
    fi
fi

convert "$image_dir/${image_file// /-}" "$destination/$converted_file"

# Print the file type confirmation
echo "File type: $format_to"
echo "Image converted to: $destination/$converted_file"
