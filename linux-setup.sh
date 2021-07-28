#!/bin/bash

slim=$1

echo "updating system"
sudo apt update
sudo apt upgrade
sudo apt install build-essential

echo "installing micro"
curl https://getmic.ro | bash
sudo mv micro /usr/bin

echo "installing fish"
sudo apt install fish
mkdir .config/fish

echo "installing rust"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

echo "installing bat"
cargo install bat exa ripgrep du-dust procs git-delta

echo "installing starship"
curl -fsSL https://starship.rs/install.sh | bash

echo "installing tmux"
sudo apt install tmux

echo "configuring dotfiles"
git clone --bare https://github.com/Zshoham/dotfiles.git $HOME/.dotfiles
/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME checkout -f

if [ "$slim" == "s" ]
then
	rm $HOME/.config/alacritty.yml
else
	echo "installing alacritty"
	sudo apt install alacritty
fi

echo "switching shell to fish"
chsh -s `which fish` 
