sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

ln -s $HOME/Code/dotfiles/shell/.zshrc ~/.zshrc
ln -s $HOME/Code/dotfiles/shell/.gitconfig ~/.gitconfig

cp ./.gitconfig.cern ~/.gitconfig.cern
cp ./.gitconfig.global ~/.gitconfig.global

source ~/.zshrc

./brew/setup_brew.sh
