#!/bin/sh

echo "installing MPV"
nix-env -iA nixpkgs.mpv

echo "installing OBS"
sudo apt install obs-studio

echo "installing GIMP"
sudo apt install gimp

echo "installing Inkscape"
sudo add-apt-repository ppa:inkscape.dev/stable
sudo apt update
sudo apt install inkscape

echo "installing Audacity"
sudo apt install audacity

echo "installing Kdenlive"
sudo add-apt-repository ppa:kdenlive/kdenlive-stable
sudo apt-get update
sudo apt install kdenlive
