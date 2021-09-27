#!/bin/sh

echo "removing libreoffice"
sudo apt remove --purge libreoffice-core
sudo apt remove --purge libreoffice-common

echo "removing firefox"
sudo apt remove --purge firefox

echo "updating system"
sudo apt autoremove
sudo apt update
sudo apt upgrade

echo "downloading desktop wallpaper"
wget -r -np --cut-dirs=1 --no-parent --reject="index.html*" https://zshoham.github.io/static/wallpaper/
sudo cp -r zshoham.github.io/wallpaper /usr/share/backgrounds
rm -rf zshoham.github.io
dconf write /org/gnome/desktop/background/picture-uri "'file:///usr/share/backgrounds/wallpaper.xml'"

echo "installing synaptic"
sudo apt install synaptic

echo "installing alacritty"
sudo apt install alacritty

echo "installing vscode"
curl -fsSLo code.deb "https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64"
sudo apt install ./code.deb
rm ./code.deb

echo "installing brave browser"
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo apt update
sudo apt install brave-browser

echo "installing stacer"
sudo apt install stacer

echo "installing gnome-boxes"
sudo apt install gnome-boxes

echo "installing telegram"
sudo apt install telegram-desktop

echo "installing spotify"
sudo curl -fsSLo /usr/share/keyrings/spotify-keyring.gpg https://download.spotify.com/debian/pubkey_0D811D58.gpg
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt update
sudo apt install spotify-client

echo "installing gnome drawing"
sudo apt install drawing

echo "installing flatpack desktop apps"
flatpak flathub com.axosoft.GitKraken \
 flathub com.discordapp.Discord

