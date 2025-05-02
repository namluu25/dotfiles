#!/bin/bash

# clean_dev_caches.sh

# Check if the script is run with a directory argument
if [ -z "$1" ]; then
    echo "Usage: $0 <directory>"
    exit 1
fi

# Function to find and remove cache directories
remove_caches() {
    local dir="$1"

    # React Native specific
    find "$dir" -type d \( -name "node_modules" -o -name "Pods" \) -prune -exec rm -rf '{}' +
    find "$dir" -type d -path "*/android/app/build" -prune -exec rm -rf '{}' +

    # Next.js specific
    find "$dir" -type d \( -name ".next" -o -name ".turbo" \) -prune -exec rm -rf '{}' +

    # Expo specific
    find "$dir" -type d \( -name ".expo" -o -name "dist" \) -prune -exec rm -rf '{}' +

    # General caches
    find "$dir" -type d \( -name ".cache" -o -name "coverage" -o -name "dist" \) -prune -exec rm -rf '{}' +

    # IDE specific
    find "$dir" -type d \( -name ".idea" -o -name ".vscode" \) -prune -exec rm -rf '{}' +

    # Build outputs
    find "$dir" -type d -name "build" -prune -exec rm -rf '{}' +

    echo "Successfully cleaned all cache directories in $dir"
}

# Call the function with the provided directory
remove_caches "$1"
