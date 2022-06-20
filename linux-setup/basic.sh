#!/bin/sh

OFF='\033[0m'
GREEN='\033[0;32m'

nice_print() {
	echo "\n$GREEN $1 $OFF"	
}

nice_print "updating system"
sudo apt update
sudo apt install build-essential

nice_print "configuring python"
sudo apt install python3-pip python-is-python3 python3-venv
pip install --user pipx

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

nice_print "installing nixpkgs"
curl -L -o nix_install.sh https://nixos.org/nix/install
sudo chmod +x nix_install.sh
./nix_install.sh --no-daemon
rm ./nix_install.sh
. $HOME/.nix-profile/etc/profile.d/nix.sh

nice_print "install command line utilities"
nix-env -i gh micro bat exa ripgrep fd sd fzf delta du-dust procs bitwarden-cli starship btop glow slides zellij helix

nice_print "installing rust"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

nice_print "installing jq"
sudo apt install jq

nice_print "installing java using jabba"
curl -sL https://github.com/shyiko/jabba/raw/master/install.sh | bash
jabba install adopt@1.8.0-292
jabba alias default adopt@1.8.0-292

nice_print "installing neofetch"
sudo apt install neofetch
