#!/bin/sh

cd ~

# homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# poweline font
git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
./install.sh
cd ..
rm -rf fonts

# iterm material theme
wget https://raw.githubusercontent.com/MartinSeeler/iterm2-material-design/master/material-design-colors.itermcolors

# install Homebrew tap
brew tap Homebrew/bundle

# moving config file
cd ~
shopt -s dotglob
mv ~/mac-setup/* ~/
# mv ~/mac-setup/*(DN) ~/
rm -rf .git

# dump formulae/cask 
brew bundle

# github config
git config --global user.email namluu253@gmail.com
git config --global user.name "Nam Luu"
git config --global core.editor nano

# nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
nvm install --lts
nvm alias default lts/*

# menubar
git clone https://github.com/Jean-Tinland/simple-bar $HOME/Library/Application\ Support/Übersicht/widgets/simple-bar

# autorun yabai and skhd
brew services start yabai
brew services start skhd

# oh-my-zsh
#sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --keep-zshrc
sh oh-my-zsh.sh --keep-zshrc
compaudit | xargs chmod g-w,o-w

# zsh syntax highlight
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# zsh auto suggestion
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# zsh2000 theme
git clone https://github.com/maverick9000/zsh2000.git
mv ~/zsh2000/zsh2000.zsh-theme ~/.oh-my-zsh/themes
rm -rf zsh2000

exec zsh -l