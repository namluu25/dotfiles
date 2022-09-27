#!/usr/bin/env zsh

# ~/.macos — https://mths.be/macos

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.macos` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# change hot corner
defaults write com.apple.dock wvous-bl-corner -int 4
defaults write com.apple.dock wvous-br-corner -int 2

# change dock size
defaults write com.apple.dock tilesize -int 50

# dock autohide
defaults write com.apple.dock autohide -bool true

# hide recent app
defaults write com.apple.dock static-only -bool false

# Remove the auto-hiding Dock delay
defaults write com.apple.dock autohide-delay -float 0

# move dock to right
defaults write com.apple.dock orientation right

# Show hidden files:
defaults write com.apple.finder AppleShowAllFiles YES;

# enable tap to click trackpad
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true

# Disable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# Require password immediately after sleep or screen saver begins
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Finder: show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Finder: show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Finder: show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Disable disk image verification
defaults write com.apple.frameworks.diskimages skip-verify -bool true
defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true
defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true

# Don’t automatically rearrange Spaces based on most recent use
defaults write com.apple.dock mru-spaces -bool false

# three finger drag
defaults -currentHost write NSGlobalDomain com.apple.trackpad.threeFingerSwipeGesture -int 1

# set new finder windows to user folder
defaults write com.apple.finder NewWindowTargetPath -string "file://$HOME/"

#disable repeat key delay
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

#hide menu bar
defaults write NSGlobalDomain _HIHideMenuBar -bool true

killall Dock
killall Finder
sudo reboot
