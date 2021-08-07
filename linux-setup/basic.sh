echo "updating system"
sudo apt update
sudo apt upgrade
sudo apt install build-essential

echo "installing micro"
curl https://getmic.ro | bash
sudo mv micro /usr/bin

echo "installing fish"
sudo apt install fish
mkdir .config/fish

echo "installing rust"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

echo "installing cmd tools"
cargo install bat exa ripgrep du-dust procs git-delta fd-find broot 

echo "installing starship"
curl -fsSL https://starship.rs/install.sh | sh

echo "installing tmux"
sudo apt install tmux

echo "installing java using jabba"
curl -sL https://github.com/shyiko/jabba/raw/master/install.sh | bash; and . ~/.jabba/jabba.fish
jabba install adopt@1.8.0-292
jabba alias default adopt@1.8.0-292

echo "installing julia"
sudo apt install julia

echo "installing golang"
sudo apt install golang

echo "installing node with fnm"
curl -fsSL https://fnm.vercel.app/install | bash
fnm install --lts

echo "configuring dotfiles"
git clone --bare https://github.com/Zshoham/dotfiles.git $HOME/.dotfiles
/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME checkout -f

echo "switching shell to fish"
chsh -s `which fish`
