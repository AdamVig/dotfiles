#!/bin/bash

declare -a brew_formulas=(
    # Upgrade default command line tools
    bash
    curl
    git
    wget
    zsh

    # Utilities
    cheat
    emacs
    httpie
    markdown
    ssh-copy-id
    z

    # Languages
    node
    python
    python3
)

declare -a cask_formulas=(
    dash
    flux
    google-chrome
    spotify
)

echo "Updating Homebrew package lists..."
brew update

echo "Upgrading installed packages..."
brew upgrade

echo "Installing Brew formulas..."

# Install Brew formulas, suppress "already installed" warnings
for formula in "${brew_formulas[@]}"; do
    brew install "$formula" 2> /dev/null
done

echo "Installing Brew Cask formulas..."

# Install Cask formulas, suppress "already installed" warnings
for formula in "${cask_formulas[@]}"; do
    brew cask install "$formula" 2> /dev/null
done

echo "Brew done."
