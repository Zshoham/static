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

echo "installing flatpack  desktop apps"
flatpak install org.telegram.desktop \
 com.bitwarden.desktop \
 com.discordapp.Discord \
 com.github.maoschanz.drawing
