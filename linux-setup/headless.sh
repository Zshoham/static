#!/bin/sh

OFF='\033[0m'
GREEN='\033[0;32m'

nice_print() {
	echo "\n$GREEN $1 $OFF"	
}

nice_print "updating system"
sudo apt update -y
sudo apt install -y build-essential

nice_print "configuring python"
sudo apt install -y python3-pip python-is-python3 python3-venv
pip install --user pipx

nice_print "installing ssh-server"
sudo apt install -y openssh-server
sudo systemctl disable ssh

nice_print "enabling ufw and disabling ssh connections from outside local network"
sudo ufw enable
sudo ufw allow from 192.168.0.0/16 to any port 22 proto tcp

nice_print "installing nixpkgs"
curl -L -o nix_install.sh https://nixos.org/nix/install
sudo chmod +x nix_install.sh
./nix_install.sh --daemon
rm ./nix_install.sh
. /etc/profile.d/nix.sh

nice_print "setting up home-manager"
nix build --no-link $HOME/.config/home-manager#homeConfigurations.$USER.activationPackage
"$(nix path-info $HOME/.config/home-manager#homeConfigurations.sgame.activationPackage)"/home-path/bin/home-manager switch -b backup --flake '$HOME/.config/home-manager#sgame'

nice_print "changing default shell to fish"
sudo chsh -s $(which fish) $USER

nice_print "installing c/c++ tooling"
sudo apt install -y cmake pkg-config clang clang-tidy lldb valgrind

nice_print "installing rust"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

nice_print "installing docker"
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update -y
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

nice_print "installing python tooling"
sudo apt install -y make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
	libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev

curl https://pyenv.run | bash
pipx install poetry
mkdir -p ~/.config/fish/completions/
poetry completions fish > $HOME/.config/fish/completions/poetry.fish

nice_print "installing perf and bpftrace"
sudo apt install -y linux-tools-generic bpftrace
