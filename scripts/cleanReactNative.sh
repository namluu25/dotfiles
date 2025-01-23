#!/bin/bash

# find_and_remove_node_modules.sh

# Check if the script is run with a directory argument
if [ -z "$1" ]; then
    echo "Usage: $0 <directory>"
    exit 1
fi

# Function to find and remove node_modules directories
remove_node_modules() {
    local dir="$1"

    # Find and remove all node_modules and Pods directories
    find "$dir" -type d \( -name "node_modules" -o -name "Pods" \) -prune -exec rm -rf '{}' +

    # Find and remove all android/app/build directories
    find "$dir" -type d -path "*/android/app/build" -prune -exec rm -rf '{}' +
}

# Call the function with the provided directory
remove_node_modules "$1"
