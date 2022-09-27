#!/bin/sh
sudo xcodebuild -license accept

# color setup
RED='\033[0;31m'
NC='\033[0m' # No Color

MACHINE_TYPE=`uname -m`
shasum=$(shasum -a 256 $(which yabai))

rm -rf .git
cd ~

printf "${RED}install homebrew${NC}\n"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

if [ ${MACHINE_TYPE} == 'arm64' ]; then
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/[your-user-name]/.zprofile
	eval "$(/opt/homebrew/bin/brew shellenv)"
fi

printf "${RED}install poweline font${NC}\n"
git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
./install.sh
cd ..
rm -rf fonts

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
sudo yabai --install-sa
sudo yabai --load-sa
brew services start yabai
brew services start skhd
brew cleanup

printf "${RED}install oh-my-zsh${NC}\n"
sh oh-my-zsh.sh --keep-zshrc

printf "${RED}install zsh syntax highlighting${NC}\n"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

printf "${RED}install zsh auto suggestion${NC}\n"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

printf "${RED}install zsh2000 theme${NC}\n"
git clone https://github.com/maverick9000/zsh2000.git
mv ~/zsh2000/zsh2000.zsh-theme ~/.oh-my-zsh/themes
rm -rf zsh2000

echo -e "${RED}Run these later${NC}\nbrew install cloudflare-warp\nbrew install karabiner-elements\nbrew install teamviewer\n"
echo -e "Run ${RED}sudo visudo -f /private/etc/sudoers.d/yabai${NC} and paste following line bellow (press i for ${RED}INSERT${NC}, ${RED}ESC+':wq'${NC} for save and quit \nnamluu ALL = (root) NOPASSWD: $shasum  --load-sa"
exec zsh -l
