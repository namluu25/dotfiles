#!/bin/sh

# color setup
RED='\033[0;31m'
NC='\033[0m' # No Color

rm -rf .git
cd ~

printf "${RED}install homebrew${NC}\n"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

printf "${RED}install poweline font${NC}\n"
git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
./install.sh
cd ..
rm -rf fonts

printf "${RED}install iterm material theme${NC}\n"
wget https://raw.githubusercontent.com/MartinSeeler/iterm2-material-design/master/material-design-colors.itermcolors

printf "${RED}install install Homebrew tap${NC}\n"
brew tap Homebrew/bundle

printf "${RED}moving config file${NC}\n"
cd ~
rm -rf .config
rm .zshrc
shopt -s dotglob
mv ~/mac-setup/* ~/
 
printf "${RED}dumping formulae/cask${NC}\n"
brew bundle

printf "${RED}configuring github${NC}\n"
git config --global user.email namluu253@gmail.com
git config --global user.name "Nam Luu"
git config --global core.editor nano

printf "${RED}setup NVM${NC}\n"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
nvm install --lts
nvm alias default lts/*

printf "${RED}install menubar${NC}\n"
git clone https://github.com/Jean-Tinland/simple-bar $HOME/Library/Application\ Support/Übersicht/widgets/simple-bar

printf "${RED}make yabai/skhd autostart${NC}\n"
brew services start yabai
brew services start skhd

printf "${RED}install oh-my-zsh${NC}\n"
#sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --keep-zshrc
sh oh-my-zsh.sh --keep-zshrc

printf "${RED}install zsh syntax highlighting${NC}\n"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

printf "${RED}install zsh auto suggestion${NC}\n"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

printf "${RED}install zsh2000 theme${NC}\n"
git clone https://github.com/maverick9000/zsh2000.git
mv ~/zsh2000/zsh2000.zsh-theme ~/.oh-my-zsh/themes
rm -rf zsh2000

exec zsh -l
