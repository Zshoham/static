#!/bin/sh

OFF='\033[0m'
GREEN='\033[0;32m'

nice_print() {
	echo "\n$GREEN $1 $OFF"	
}

nice_print "installing beekeper studio"
curl -LsS https://deb.beekeeperstudio.io/beekeeper.key | gpg --dearmor | sudo tee /usr/share/keyrings/deb.beekeeperstudio.io-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/deb.beekeeperstudio.io-archive-keyring.gpg] https://deb.beekeeperstudio.io stable main" | sudo tee /etc/apt/sources.list.d/beekeeper-studio-app.list
sudo apt update
sudo apt install beekeeper-studio

nice_print "installing wireshark"
sudo apt install wireshark

nice_print "installing flatpak apps"
flatpak install flathub rest.insomnia.Insomnia \
 com.axosoft.GitKraken
