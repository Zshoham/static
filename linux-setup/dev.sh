#!/bin/sh

echo "installing c/c++ tooling"
sudo apt install cmake
sudo apt install clang clang-tidy lldb
sudo apt install valgrind

echo "installing julia"
sudo apt install julia

echo "installing golang"
sudo apt install golang

echo "installing node with fnm"
curl -fsSL https://fnm.vercel.app/install | bash -s -- --install-dir "$HOME/.local/share/fnm"
fnm install --lts

echo "installing python tooling"
curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/install-poetry.py | python -

curl -o conda-installer.sh https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
sudo chmod u+x conda-installer.sh
sudo ./conda-installer.sh -b -p $HOME/.local/share/conda
rm conda-installer.sh
$HOME/.local/share/conda/bin/conda init fish
sudo chown -R $USER $HOME/.local/share/conda

echo "installing perf and bpftrace"
sudo apt install linux-tools-generic bpftrace

echo "installing jq"
sudo apt install jq

echo "installing podman"
sudo apt install podman

echo "installing hexyl"
cargo install hexyl
