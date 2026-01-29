#!/bin/sh

# color setup
RED='\033[0;31m'
NC='\033[0m' # No Color
root_dir=$HOME/dotfiles

MACHINE_TYPE=`uname -m`
read -p "Press enter to continue"
if [ ${MACHINE_TYPE} == 'arm64' ]; then
    softwareupdate --install-rosetta
fi
sudo xcodebuild -license accept

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


printf "=>>${RED}moving config file${NC}\n"
rm -rf $HOME/.config
rm $HOME/.zshrc
sudo bash ${root_dir}/scripts/symlinks.sh $HOME/dotfiles/dotfiles

printf "=>>${RED}dumping formulae/cask${NC}\n"
cd ${root_dir}/configs
brew bundle -v
cd ${root_dir}

printf "=>>${RED}configuring github${NC}\n"
git config --global user.email namluu253@gmail.com
git config --global user.name "Nam Luu"
git config --global core.excludesfile ~/.gitignore

printf "==> ${RED}Installing latest Xcode${NC}\n"
xcodes install --latest --experimental-unxip

printf "=>>${RED}install oh-my-zsh${NC}\n"
sh $HOME/dotfiles/scripts/oh-my-zsh.sh --keep-zshrc

printf "=>>${RED}install tpm${NC}\n"
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

printf "=>>${RED}install zsh syntax highlighting${NC}\n"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

printf "=>>${RED}install zsh auto suggestion${NC}\n"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

printf "=>>${RED}install powerlevel10k theme${NC}\n"
cd $HOME
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

