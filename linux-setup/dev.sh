#!/bin/sh

OFF='\033[0m'
GREEN='\033[0;32m'

nice_print() {
	echo "\n$GREEN $1 $OFF"	
}

nice_print "installing c/c++ tooling"
sudo apt install cmake
sudo apt install clang clang-tidy lldb
sudo apt install valgrind

nice_print "installing just"
curl --proto '=https' --tlsv1.2 -sSf https://just.systems/install.sh | sudo bash -s -- --to /usr/bin

nice_print "installing cargo utilities"
sudo apt install libssl-dev
cargo install cargo-edit cargo-update

nice_print "installing julia"
sudo apt install julia

nice_print "installing golang"
sudo apt install golang

nice_print "installing node with fnm"
curl -fsSL https://fnm.vercel.app/install | bash -s -- --install-dir "$HOME/.local/share/fnm"
fnm install --lts

nice_print "installing python tooling"
curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/install-poetry.py | python -

curl -o conda-installer.sh https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
sudo chmod u+x conda-installer.sh
sudo ./conda-installer.sh -b -p $HOME/.local/share/conda
rm conda-installer.sh
$HOME/.local/share/conda/bin/conda init fish
sudo chown -R $USER $HOME/.local/share/conda
$HOME/.local/share/conda/bin/conda config --set auto_activate_base false

nice_print "installing perf and bpftrace"
sudo apt install linux-tools-generic bpftrace

nice_print "installing podman"
sudo apt install podman

nice_print "installing hexyl"
cargo install hexyl
