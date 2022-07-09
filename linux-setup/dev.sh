#!/bin/sh

OFF='\033[0m'
GREEN='\033[0;32m'

nice_print() {
	echo "\n$GREEN $1 $OFF"	
}

nice_print "installing c/c++ tooling"
sudo apt install cmake pkg-config
sudo apt install clang clang-tidy lldb
sudo apt install valgrind

nice_print "installing just"
nix-env -iA nixpkgs.just

nice_print "installing cargo utilities"
sudo apt install libssl-dev
cargo install cargo-edit cargo-update

nice_print "installing golang"
sudo apt install golang

nice_print "installing node with fnm"
nix-env -iA nixpkgs.fnm
fnm install --lts
fnm default lts-latest
fnm use lts-latest

nice_print "installing python tooling"
sudo apt install make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
	libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev

curl https://pyenv.run | bash
pipx install poetry
poetry completions fish > ~/.config/fish/completions/poetry.fish

nice_print "installing perf and bpftrace"
sudo apt install linux-tools-generic bpftrace

nice_print "installing podman"
sudo apt install podman

nice_print "installing hexyl"
nix-env -i hexyl
