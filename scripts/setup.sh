#!/bin/sh

# color setup
RED='\033[0;31m'
NC='\033[0m' # No Color

MACHINE_TYPE=`uname -m`

printf "=>>${RED}install homebrew${NC}\n"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

if [ ${MACHINE_TYPE} == 'arm64' ]; then
	echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile
	eval "$(/opt/homebrew/bin/brew shellenv)"
fi

printf "=>>${RED}install poweline font${NC}\n"
git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
./install.sh
cd ..
rm -rf fonts

printf "=>>${RED}install install Homebrew tap${NC}\n"
brew tap Homebrew/bundle

printf "=>>${RED}moving config file${NC}\n"
rm -rf $HOME/.config
rm $HOME/.zshrc
shopt -s dotglob
cp -rs $HOME/dotfiles/dotfiles/* $HOME

printf "=>>${RED}dumping formulae/cask${NC}\n"
cd $HOME/dotfiles/configs
brew bundle
cd $HOME/dotfiles

printf "=>>${RED}configuring github${NC}\n"
git config --global user.email namluu253@gmail.com
git config --global user.name "Nam Luu"
git config --global core.editor nano
git config --global core.excludesfile ~/.gitignore

printf "=>>${RED}setup NVM${NC}\n"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
nvm install 16.17
nvm alias default node

printf "=>>${RED}install menubar${NC}\n"
git clone https://github.com/wernjie/clarity $HOME/Library/Application\ Support/Übersicht/widgets/clarity

if [ ${MACHINE_TYPE} == 'arm64' ]; then
    sudo ln -s /opt/homebrew/bin/yabai /usr/local/bin/yabai
fi

printf "=>>${RED}make yabai/skhd autostart${NC}\n"
#sudo yabai --install-sa
#sudo yabai --load-sa
brew services start yabai
brew services start skhd
brew cleanup

printf "=>>${RED}install oh-my-zsh${NC}\n"
sh $HOME/dotfiles/scripts/oh-my-zsh.sh --keep-zshrc

printf "=>>${RED}install zsh syntax highlighting${NC}\n"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

printf "=>>${RED}install zsh auto suggestion${NC}\n"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

printf "=>>${RED}install powerlevel10k theme${NC}\n"
cd $HOME
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

echo -e "=>>${RED}Run these later${NC}\nbrew install --cask cloudflare-warp karabiner-elements parsec teamviewer zulu11\n"

shasum=$(shasum -a 256 $(which yabai))

echo -e "=>>Run ${RED}sudo visudo -f /private/etc/sudoers.d/yabai${NC} and paste following line bellow \nnamluu ALL = (root) NOPASSWD: sha256:$shasum --load-sa"

exec zsh -l
