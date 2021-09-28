#!/bin/sh

OFF='\033[0m'
GREEN='\033[0;32m'

nice_print() {
	echo "\n$GREEN $1 $OFF$"	
}

nice_print "updating system"
sudo apt update
sudo apt install build-essential

nice_print "make python3 default"
sudo apt install python3-pip
sudo apt install python-is-python3

nice_print "installing ssh-server"
sudo apt install openssh-server
sudo systemctl disable ssh

nice_print "enabling ufw and disabling ssh connections from outside local network"
sudo ufw enable
sudo ufw allow from 192.168.0.0/16 to any port 22 proto tcp

nice_print "Before starting the setup make sure your ssh and GPG keys are set up"
read -r -p "Are you set up ? [y/n]: " choice
if [ "$choice" = "${choice#[Yy]}" ] ;then
    exit 1
fi

nice_print "installing jetrains mono font"
curl -fsSL https://raw.githubusercontent.com/JetBrains/JetBrainsMono/master/install_manual.sh | bash
curl -fsSL https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/JetBrainsMono.zip -o JetBrainsMono.zip
unzip JetBrainsMono.zip -d JetBrainsMono
cp JetBrainsMono/* $HOME/.local/share/fonts
rm JetBrainsMono.zip
rm -rf JetBrainsMono

nice_print "installing github cli"
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo gpg --dearmor -o /usr/share/keyrings/githubcli-archive-keyring.gpg
nice_print "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
sudo apt update
sudo apt install gh

nice_print "installing micro"
curl https://getmic.ro | bash
sudo mv micro /usr/bin

nice_print "installing fish"
sudo apt install fish
mkdir .config/fish

nice_print "changing default shell to fish"
sudo chsh -s `which fish`

nice_print "installing rust"
export CARGO_HOME="$HOME/.local/share/cargo"
export RUSTUP_HOME="$HOME/.local/share/rustup"
export PATH="$CARGO_HOME/bin:$PATH"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

nice_print "installing cmd tools"
$CARGO_HOME/bin/cargo install bat exa ripgrep du-dust procs git-delta fd-find broot
sudo apt install jq


nice_print "installing bitwarden cli"
bw_url=`curl --silent "https://api.github.com/repos/bitwarden/cli/releases/latest" \
 | jq -r '.assets | .[].browser_download_url' \
 | rg 'bw-linux.*.zip'`

wget -O bw.zip "$bw_url"
sudo unzip -d /usr/bin bw.zip
sudo chmod +x /usr/bin/bw
rm bw.zip

nice_print "installing starship"
curl -fsSL https://starship.rs/install.sh | sh

nice_print "installing tmux"
sudo apt install tmux

nice_print "installing java using jabba"
export JABBA_HOME="$HOME/.local/share/jabba"
export PATH="$JABBA_HOME/bin:$PATH"
curl -sL https://github.com/shyiko/jabba/raw/master/install.sh | bash
jabba install adopt@1.8.0-292
jabba alias default adopt@1.8.0-292

nice_print "installing chezmoi"
sudo sh -c "$(curl -fsLS git.io/chezmoi) -b /usr/bin"

cd $HOME

chezmoi init --apply --ssh Zshoham


