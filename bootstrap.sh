sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

ln -s $HOME/Code/dotfiles/shell/.zshrc ~/.zshrc
ln -s $HOME/Code/dotfiles/shell/.gitconfig ~/.gitconfig

source ~/.zshrc

./brew/setup_brew.sh
