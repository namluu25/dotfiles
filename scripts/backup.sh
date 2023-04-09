#!/bin/sh

cd $HOME/dotfiles/configs
mv Brewfile Brewfile_$(date +%F)
brew bundle dump
