sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

ln -s ./shell/.zshrc ~/.zshrc
ln -s ./.gitconfig ~/.gitconfig

source ~/.zshrc

./brew/setup_brew.sh
