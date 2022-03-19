#!/bin/sh

OFF='\033[0m'
GREEN='\033[0;32m'

nice_print() {
	echo "\n$GREEN $1 $OFF"	
}

nice_print "Before starting the setup make sure your SSH and GPG keys are set up"
read -r -p "Are you set up ? [y/n]: " choice
if [ "$choice" = "${choice#[Yy]}" ] ;then
    exit 1
fi

nice_print "updating system"
sudo apt update
sudo apt install build-essential

nice_print "make python3 default"
sudo apt install python3-pip python-is-python3

nice_print "installing ssh-server"
sudo apt install openssh-server
sudo systemctl disable ssh

nice_print "enabling ufw and disabling ssh connections from outside local network"
sudo ufw enable
sudo ufw allow from 192.168.0.0/16 to any port 22 proto tcp

nice_print "installing fish"
sudo apt install fish
mkdir .config/fish

nice_print "changing default shell to fish"
chsh -s `which fish`

nice_print "installing jetrains mono font"
curl -fsSL https://raw.githubusercontent.com/JetBrains/JetBrainsMono/master/install_manual.sh | bash
curl -fsSL https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip -o JetBrainsMono.zip
unzip JetBrainsMono.zip -d JetBrainsMono
cp JetBrainsMono/* $HOME/.local/share/fonts
rm JetBrainsMono.zip
rm -rf JetBrainsMono

nice_print "installing nixpkgs"
curl -L -o nix_install.sh https://nixos.org/nix/install
sudo chmod +x nix_install.sh
./nix_install.sh --daemon
rm ./nix_install.sh
. /etc/profile.d/nix.sh
nix-channel --add https://nixos.org/channels/nixpkgs-unstable


nice_print "install command line utilities"
nix-env -i gh micro bat exa ripgrep fd fzf delta du-dust bitwarden-cli starship btop

nice_print "installing rust"
export CARGO_HOME="$HOME/.local/share/cargo"
export RUSTUP_HOME="$HOME/.local/share/rustup"
export PATH="$CARGO_HOME/bin:$PATH"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

nice_print "installing jq"
sudo apt install jq

nice_print "installing tmux"
sudo apt install tmux

nice_print "installing java using jabba"
export JABBA_HOME="$HOME/.local/share/jabba"
export PATH="$JABBA_HOME/bin:$PATH"
curl -sL https://github.com/shyiko/jabba/raw/master/install.sh | bash
jabba install adopt@1.8.0-292
jabba alias default adopt@1.8.0-292

nice_print "installing neofetch"
sudo apt install neofetch

nice_print "installing chezmoi"
nix-env -i chezmoi

cd $HOME

chezmoi init --apply --ssh Zshoham

nice_print "rebooting system to apply all changes"
shutdown -r
