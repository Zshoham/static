#!/bin/sh

OFF='\033[0m'
GREEN='\033[0;32m'

nice_print() {
	echo "\n$GREEN $1 $OFF"	
}

nice_print "removing libreoffice"
sudo apt remove -y --purge libreoffice-core
sudo apt remove -y --purge libreoffice-common

nice_print "removing firefox"
sudo apt remove -y --purge firefox

nice_print "updating system"
sudo apt autoremove
sudo apt upgrade

nice_print "downloading desktop wallpaper"
wget -r -np --cut-dirs=1 --no-parent --reject="index.html*" https://zshoham.github.io/static/wallpaper/
sudo cp -r zshoham.github.io/wallpaper /usr/share/backgrounds
rm -rf zshoham.github.io
dconf write /org/gnome/desktop/background/picture-uri "'file:///usr/share/backgrounds/wallpaper.xml'"

nice_print "installing synaptic"
sudo apt install synaptic

nice_print "installing alacritty"
sudo apt install alacritty

nice_print "installing vscode"
curl -fsSLo code.deb "https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64"
sudo apt install ./code.deb
rm ./code.deb

nice_print "installing brave browser"
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
nice_print "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo apt update
sudo apt install brave-browser

nice_print "installing stacer"
sudo apt install stacer

nice_print "installing gnome-boxes"
sudo apt install gnome-boxes

nice_print "installing telegram"
sudo apt install telegram-desktop

nice_print "installing spotify"
sudo curl -fsSLo /usr/share/keyrings/spotify-keyring.gpg https://download.spotify.com/debian/pubkey_0D811D58.gpg
nice_print "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt update
sudo apt install spotify-client

nice_print "installing gnome drawing"
sudo apt install drawing

nice_print "installing flatpack desktop apps"
flatpak flathub com.axosoft.GitKraken \
 flathub com.discordapp.Discord

