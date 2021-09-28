#!/bin/sh

OFF='\033[0m'
GREEN='\033[0;32m'

nice_print() {
	echo "\n$GREEN $1 $OFF"	
}

nice_print "installing LaTex"
sudo apt install texlive texlive-publishers texlive-science texlive-pstricks texlive-pictures texlive-xetex texlive-lang-other

nice_print "installing Obsidian"
flatpak install flathub md.obsidian.Obsidian 
