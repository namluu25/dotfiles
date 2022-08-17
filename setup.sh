#!/bin/sh

# xcode build tool
xcode-select --install

# homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# zsh2000 theme
git clone https://github.com/maverick9000/zsh2000.git
ln -s zsh2000.zsh-theme ~/.oh-my-zsh/themes/zsh2000.zsh-theme

# poweline font
git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
./install.sh
cd ..
rm -rf fonts

# iterm material theme
curl -o material-design-colors.itermcolors https://raw.githubusercontent.com/MartinSeeler/iterm2-material-design/master/material-design-colors.itermcolors

# install Homebrew tap
brew tap Homebrew/bundle

# install git and moving config file
brew install git
git clone https://github.com/namluu25/mac-setup
rm .zshrc
rm -rf .config
mv ~/mac-setup/* ~

# dump formulae/cask 
brew bundle

# github config
git config --global user.email namluu253@gmail.com
git config --global user.name "Nam Luu"
git config --global core.editor nano

# nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
nvm install --lts
nvm alias default lts/*

# menubar
git clone https://github.com/Jean-Tinland/simple-bar $HOME/Library/Application\ Support/Übersicht/widgets/simple-bar

# jetbrain font
# brew install --cask font-jetbrains-mono

# autorun yabai and skhd
brew services start yabai
brew services start skhd

# restart zsh
source ~/.zshrc
