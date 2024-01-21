#!/bin/bash

# Verify if a path argument is provided
if [ $# -eq 0 ] || [ ! -d "$1" ]; then
    echo "Please provide a valid directory path as an argument."
    exit 1
fi

repo_path="$1"

# Function to recursively create symbolic links
create_symlinks() {
    local source_dir=$1
    local target_dir=$2

    # Loop through the files in the source directory, including hidden files
    shopt -s dotglob
    for file in "$source_dir"/*; do
        # Get the filename without the path
        filename=$(basename "$file")
        
        # Check if the file is a directory
        if [ -d "$file" ]; then
            # Create the corresponding directory in the target directory
            mkdir -p "$target_dir/$filename"
            chmod 777 "$target_dir/$filename"

            # Recursively call the function on the subdirectory
            create_symlinks "$file" "$target_dir/$filename"
        else
            # Create a symbolic link in the target directory pointing to the file in the source directory
            ln -sf "$file" "$target_dir/$filename"
        fi
    done
}

# Call the function to create symbolic links starting from the repository directory to the home directory
create_symlinks "$repo_path" "$HOME"
