#!/bin/bash

# Install Homebrew if not installed
if ! command -v brew &>/dev/null; then
    echo "Homebrew not found. Installing..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "Homebrew already installed."
fi

# Install regular formulae
if [ -f "./brew/brew_programs_list.txt" ]; then
    echo "Installing formulae from brew_programs_list.txt..."
    xargs brew install < ./brew/brew_programs_list.txt
else
    echo "Error: brew_programs_list.txt not found!"
fi

# Install cask packages
if [ -f "./brew/brew_casks_list.txt" ]; then
    echo "Installing cask packages from brew_casks_list.txt..."
    xargs brew install --cask < ./brew/brew_casks_list.txt
else
    echo "Error: brew_casks_list.txt not found!"
fi

echo "Installation complete!"


