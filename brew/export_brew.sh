#!/bin/bash
#!/usr/bin/env bash

brew update
brew upgrade

BREW_PREFIX=$(brew --prefix)
ln -s "${BREW_PREFIX}/bin/gsha256sum" "${BREW_PREFIX}/bin/sha256sum"
FORMULAE_FILE="brew_programs_list.txt"
CASKS_FILE="brew_casks_list.txt"

# Export installed formulae
echo "Exporting Homebrew list..."
brew list --formula > "$FORMULAE_FILE"
if [ $? -eq 0 ]; then
    echo "Successfully exported formulae."
else
    echo "Error exporting formulae!" >&2
    exit 1
fi

# Export installed casks
brew list --cask > "$CASKS_FILE"
if [ $? -eq 0 ]; then
    echo "Successfully exported casks."
else
    echo "Error exporting casks!" >&2
    exit 1
fi

brew cleanup
