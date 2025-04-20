#!/bin/bash

# Check if folder name is provided as argument
if [ $# -eq 0 ]; then
    echo "Error: Please provide a folder name to search and remove"
    echo "Usage: sudo $0 <folder_name>"
    exit 1
fi

# Check if script is run with sudo
if [ "$EUID" -ne 0 ]; then
    echo "Please run with sudo privileges to search entire disk"
    echo "Usage: sudo $0 <folder_name>"
    exit 1
fi

folder_name="$1"

echo "Searching for directories named '$folder_name' across entire disk..."
echo "This might take a while..."

# First, find and list all matching directories, excluding certain system paths
matching_dirs=$(find / -type d -name "$folder_name" \
    -not -path "/proc/*" \
    -not -path "/sys/*" \
    -not -path "/dev/*" \
    -not -path "/run/*" \
    2>/dev/null)

if [ -z "$matching_dirs" ]; then
    echo "No directories found matching '$folder_name'"
    exit 0
fi

# Print all found directories with numbers
i=1
echo -e "\nFound the following directories:"
echo "$matching_dirs" | while read -r dir; do
    echo "[$i] $dir"
    i=$((i + 1))
done

# Ask for general confirmation
echo -e "\nWarning: Removing system directories can be dangerous!"
read -p "Do you want to proceed with removal? (y/n): " proceed

if [ "$proceed" != "y" ] && [ "$proceed" != "Y" ]; then
    echo "Operation cancelled"
    exit 0
fi

# Process each directory
echo "$matching_dirs" | while read -r dir; do
    echo -e "\nProcessing: $dir"
    read -p "Remove this folder? (y/n): " answer
    if [ "$answer" = "y" ] || [ "$answer" = "Y" ]; then
        rm -rf "$dir"
        echo "Removed: $dir"
    else
        echo "Skipped: $dir"
    fi
done
