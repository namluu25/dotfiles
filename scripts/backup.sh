#!/bin/sh

cd $HOME/dotfiles/configs
mv Brewfile Brewfile_old
brew bundle dump
