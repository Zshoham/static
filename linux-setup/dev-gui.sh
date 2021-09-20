#!/bin/bash

echo "installing beekeper studio"
wget --quiet -O - https://deb.beekeeperstudio.io/beekeeper.key | gpg --dearmor | sudo tee /usr/share/keyrings/deb.beekeeperstudio.io-archive-keyring.gpg
echo "deb https://deb.beekeeperstudio.io stable main" | sudo tee /etc/apt/sources.list.d/beekeeper-studio-app.list
sudo apt update
sudo apt install beekeeper-studio

echo "installing wireshark"
sudo apt install wireshark

flatpak install flathub rest.insomnia.Insomnia \
 com.axosoft.GitKraken
