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
nix-env -iA nixpkgs.just

nice_print "installing cargo utilities"
sudo apt install libssl-dev
cargo install cargo-edit cargo-update

nice_print "installing julia"
sudo apt install julia

nice_print "installing golang"
sudo apt install golang

nice_print "installing node with fnm"
nix-env -iA nixpkgs.fnm
fnm install --lts
fnm default lts-latest
fnm use lts-latest

nice_print "installing python tooling"
curl https://pyenv.run | bash

nice_print "installing perf and bpftrace"
sudo apt install linux-tools-generic bpftrace

nice_print "installing podman"
sudo apt install podman

nice_print "installing hexyl"
nix-env -i hexyl
