echo "removing libreoffice"
sudo apt remove --purge libreoffice-core

echo "installing alacritty"
sudo apt install alacritty

echo "installing vscode"
curl -fsSLo code.deb "https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64"
sudo apt install ./code.deb
rm ./code.deb

echo "installing desktop apps"
flatpak install org.telegram.desktop com.bitwarden.desktop com.discordapp.Discord us.zoom.Zoom com.spotify.Client
