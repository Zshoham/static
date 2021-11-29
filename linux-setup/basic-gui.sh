#!/bin/sh

OFF='\033[0m'
GREEN='\033[0;32m'

nice_print() {
	echo "\n$GREEN $1 $OFF"	
}

nice_print "removing libreoffice"
sudo apt remove --purge libreoffice-core
sudo apt remove --purge libreoffice-common

nice_print "removing firefox"
sudo apt remove --purge firefox
sudo apt remove --purge firefox-locale-ar firefox-locale-de firefox-locale-en firefox-locale-es firefox-locale-fr firefox-locale-it firefox-locale-ja firefox-locale-pt firefox-locale-ru firefox-locale-zh-hans firefox-locale-zh-hant

nice_print "updating system"
sudo apt autoremove
sudo apt upgrade

nice_print "downloading desktop wallpaper"
wget -r -np --cut-dirs=1 --no-parent --reject="index.html*" https://zshoham.github.io/static/wallpaper/
sudo cp -r zshoham.github.io/wallpaper/* /usr/share/backgrounds
rm -rf zshoham.github.io

nice_print "installing MPV"
nix-env -iA nixpkgs.mpv

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

nice_print "installing gnome-boxes"
sudo apt install gnome-boxes

nice_print "installing telegram"
sudo apt install telegram-desktop

nice_print "installing spotify"
sudo curl -fsSL https://download.spotify.com/debian/pubkey_0D811D58.gpg | gpg --dearmor | sudo tee /usr/share/keyrings/spotify-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/spotify-keyring.gpg] http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt update
sudo apt install spotify-client

nice_print "installing gnome drawing"
sudo apt install drawing

nice_print "installing discord"
flatpak install flathub com.discordapp.Discord

nice_print "applying gnome settings"

# general
dconf write /org/gnome/desktop/background/picture-uri "'file:///usr/share/backgrounds/wallpaper.xml'"
dconf write /org/gnome/system/location/enabled "false"
dconf write /org/gnome/shell/favorite-apps "['/org/gnome/shell/favorite-apps', 'io.elementary.appcenter.desktop', 'com.alacritty.Alacritty.desktop', 'brave-browser.desktop']"
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

# make startup script executable
sudo chmod +x $HOME/.config/fish/startup.fish
