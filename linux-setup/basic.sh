#!/bin/sh

echo "updating system"
sudo apt update
sudo apt upgrade
sudo apt install build-essential

echo "make python3 default"
sudo apt install python3-pip
sudo apt install python-is-python3

echo "installing ssh-server"
sudo apt install openssh-server
sudo systemctl disable ssh

echo "enabling ufw and disabling ssh connections from outside local network"
sudo ufw enable
sudo ufw allow from 192.168.0.0/16 to any port 22 proto tcp

echo "Before starting the setup make sure your ssh and GPG keys are set up"
read -p "Are you set up ? [y/n]: " choice
if [[ $choice == [Nn]* ]]; then
	exit 1
fi

echo "installing jetrains mono font"
curl -fsSL https://raw.githubusercontent.com/JetBrains/JetBrainsMono/master/install_manual.sh | bash
curl -fsSL https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/JetBrainsMono.zip -o JetBrainsMono.zip
unzip JetBrainsMono.zip -d JetBrainsMono
cp JetBrainsMono/* $HOME/.local/share/fonts
rm JetBrainsMono.zip
rm -rf JetBrainsMono 

echo "installing github cli"
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo gpg --dearmor -o /usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
sudo apt update
sudo apt install gh

echo "installing just"
curl --proto '=https' --tlsv1.2 -sSf https://just.systems/install.sh | sudo bash -s -- --to /usr/bin

echo "installing bitwarden cli"
bw_url=`curl --silent "https://api.github.com/repos/bitwarden/cli/releases/latest" \
 | jq -r '.assets | .[].browser_download_url' \
 | rg 'bw-linux.*.zip'`

wget -O bw.zip "${bw_url}"
sudo unzip -d /usr/bin bw.zip
sudo chmod +x /usr/bin/bw
rm bw.zip

echo "installing micro"
curl https://getmic.ro | bash
sudo mv micro /usr/bin

echo "installing fish"
sudo apt install fish
mkdir .config/fish

echo "installing rust"
export CARGO_HOME="$HOME/.local/share/cargo"
export RUSTUP_HOME="$HOME/.local/share/rustup"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

echo "installing cmd tools"
cargo install bat exa ripgrep du-dust procs git-delta fd-find broot cargo-edit cargo-update

echo "installing starship"
curl -fsSL https://starship.rs/install.sh | sh

echo "installing tmux"
sudo apt install tmux

echo "installing java using jabba"
export JABBA_HOME="$HOME/.local/share/jabba"
curl -sL https://github.com/shyiko/jabba/raw/master/install.sh | bash; and . ~/.jabba/jabba.fish
jabba install adopt@1.8.0-292
jabba alias default adopt@1.8.0-292

echo "installing chezmoi"
sh -c "$(curl -fsLS git.io/chezmoi) -b /usr/bin"

echo "switching shell to fish"
chsh -s `which fish`

cd $HOME

fish -C "chezmoi init" -i
