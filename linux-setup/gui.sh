#!/bin/sh

OFF='\033[0m'
GREEN='\033[0;32m'

nice_print() {
	echo "\n$GREEN $1 $OFF"	
}

nice_print "removing libreoffice"
sudo apt remove -y  --purge `apt list --installed | grep libreoffice | cut -d "/" -f 1`

nice_print "removing firefox"
sudo apt remove -y --purge `apt list --installed | grep firefox | cut -d "/" -f 1`
rm -rf $HOME/.mozilla/
rm -rf /usr/lib/firefox/

nice_print "removing pop-shop"
sudo apt remove -y --purge pop-shop

nice_print "updating system"
sudo apt update -y 
sudo apt autoremove -y
sudo apt upgrade -y

nice_print "downloading desktop wallpaper"
wget -r -np --cut-dirs=1 --no-parent --reject="index.html*" https://zshoham.github.io/static/wallpaper/
sudo cp -r zshoham.github.io/wallpaper/* /usr/share/backgrounds
rm -rf zshoham.github.io

nice_print "installing kitty"
kitty-update

nice_print "installing MPV"
sudo apt install -y mpv

nice_print "installing zathura"
sudo apt install -y zathura

nice_print "installing vscode"
curl -fsSLo code.deb "https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64"
sudo apt install -y ./code.deb
rm ./code.deb

nice_print "installing brave browser"
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo apt update -y
sudo apt install -y brave-browser

nice_print "installing stacer"
sudo apt install -y stacer

nice_print "installing virt-manager"
sudo apt install -y virt-manager

nice_print "installing telegram"
sudo apt install -y telegram-desktop

nice_print "installing spotify"
curl -sS https://download.spotify.com/debian/pubkey_5E3C45D7B312C643.gpg | gpg --dearmor | sudo tee /usr/share/keyrings/spotify-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/spotify-keyring.gpg] http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt update
sudo apt install -y spotify-client

nice_print "installing qbittorrent"
sudo apt install -y qbittorrent

nice_print "installing discord"
flatpak install -y flathub com.discordapp.Discord

nice_print "installing beekeper studio"
curl -LsS https://deb.beekeeperstudio.io/beekeeper.key | gpg --dearmor | sudo tee /usr/share/keyrings/deb.beekeeperstudio.io-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/deb.beekeeperstudio.io-archive-keyring.gpg] https://deb.beekeeperstudio.io stable main" | sudo tee /etc/apt/sources.list.d/beekeeper-studio-app.list
sudo apt update -y 
sudo apt install -y beekeeper-studio

nice_print "installing wireshark"
sudo apt install -y wireshark

nice_print "installing flatpak apps"
flatpak install -y flathub rest.insomnia.Insomnia \
 com.axosoft.GitKraken

