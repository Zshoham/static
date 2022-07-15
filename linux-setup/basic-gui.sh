#!/bin/sh

OFF='\033[0m'
GREEN='\033[0;32m'

nice_print() {
	echo "\n$GREEN $1 $OFF"	
}

nice_print "removing libreoffice"
sudo apt remove --purge `apt list --installed | grep libreoffice | cut -d "/" -f 1`

nice_print "removing firefox"
sudo apt remove --purge `apt list --installed | grep firefox | cut -d "/" -f 1`
rm -rf $HOME/.mozilla/
rm -rf /usr/lib/firefox/

nice_print "removing pop-shop"
sudo apt remove --purge pop-shop

nice_print "updating system"
sudo apt update
sudo apt autoremove
sudo apt upgrade

nice_print "downloading desktop wallpaper"
wget -r -np --cut-dirs=1 --no-parent --reject="index.html*" https://zshoham.github.io/static/wallpaper/
sudo cp -r zshoham.github.io/wallpaper/* /usr/share/backgrounds
rm -rf zshoham.github.io

nice_print "installing jetrains mono font"
curl -fsSL https://raw.githubusercontent.com/JetBrains/JetBrainsMono/master/install_manual.sh | bash
curl -fsSL https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip -o JetBrainsMono.zip
unzip JetBrainsMono.zip -d JetBrainsMono
cp JetBrainsMono/* $HOME/.local/share/fonts
rm JetBrainsMono.zip
rm -rf JetBrainsMono

nice_print "installing MPV"
sudo apt install mpv

nice_print "installing zathura"
sudo apt install zathura

nice_print "installing ani-cli"
git clone "https://github.com/pystardust/ani-cli.git" && cd ./ani-cli
sudo cp ./bin/ani-cli /usr/local/bin
sudo cp -a ./lib/ani-cli /usr/local/lib
cd .. && rm -rf "./ani-cli"

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
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo apt update
sudo apt install brave-browser

nice_print "installing stacer"
sudo apt install stacer

nice_print "installing virt-manager"
sudo apt install virt-manager

nice_print "installing telegram"
sudo apt install telegram-desktop

nice_print "installing spotify"
curl -sS https://download.spotify.com/debian/pubkey_5E3C45D7B312C643.gpg | gpg --dearmor | sudo tee /usr/share/keyrings/spotify-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/spotify-keyring.gpg] http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt update
sudo apt install spotify-client

nice_print "installing qbittorrent"
sudo apt install qbittorrent

nice_print "installing gnome drawing"
sudo apt install drawing

nice_print "installing discord"
flatpak install flathub com.discordapp.Discord

nice_print "applying gnome settings"

# general
dconf write /org/gnome/desktop/background/picture-uri "'file:///usr/share/backgrounds/wallpaper.xml'"
dconf write /org/gnome/desktop/background/picture-uri-dark "'file:///usr/share/backgrounds/wallpaper.xml'"
dconf write /org/gnome/system/location/enabled "false"
dconf write /org/gnome/shell/favorite-apps "['/org/gnome/shell/favorite-apps', 'com.alacritty.Alacritty.desktop', 'brave-browser.desktop']"
dconf write /org/gnome/desktop/wm/preferences/button-layout "'appmenu:minimize,maximize,close'"

# dock settings
dconf write /org/gnome/shell/extensions/dash-to-dock/dash-max-icon-size "36"
dconf write /org/gnome/shell/extensions/dash-to-dock/dock-fixed "false"
dconf write /org/gnome/shell/extensions/dash-to-dock/intellihide "true"
dconf write /org/gnome/shell/extensions/dash-to-dock/manualhide "false"

# pop-os settings
dconf write /org/gnome/shell/extensions/pop-shell/tile-by-default "true"
dconf write /org/gnome/shell/extensions/pop-shell/active-hint "true"
dconf write /org/gnome/shell/extensions/pop-shell/show-title "false"
dconf write /org/gnome/shell/extensions/pop-shell/hint-color-rgba "'rgb(213,196,161)'"
dconf write /org/gnome/shell/extensions/pop-cosmic/show-applications-button "false"

# touchpad
dconf write /org/gnome/desktop/peripherals/touchpad/two-finger-scrolling-enabled "true"
dconf write /org/gnome/desktop/peripherals/touchpad/natural-scroll "true"
