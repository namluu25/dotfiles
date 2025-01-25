#!/bin/sh

echo "Backing up brew"
cd $HOME/dotfiles/configs
mv Brewfile Brewfile_$(date +%F)
brew bundle dump --taps --brews --casks --mas

# Removing react native cache
echo "Remove React Native cache"
bash $HOME/dotfiles/scripts/cleanReactNative.sh $HOME/dev

# Check if the dev folder, .ssh folder, and .zsh_history file exist
if [ ! -d "$HOME/dev" ]; then
    echo "Warning: 'dev' folder does not exist."
fi

if [ ! -d "$HOME/.ssh" ]; then
    echo "Warning: '.ssh' folder does not exist."
fi

if [ ! -f "$HOME/.zsh_history" ]; then
    echo "Warning: '.zsh_history' file does not exist."
fi

# Create the zip archive
zip -rq "$HOME/backup.zip" "$HOME/dev" "$HOME/.ssh" "$HOME/.zsh_history"

echo "Backup created" 
