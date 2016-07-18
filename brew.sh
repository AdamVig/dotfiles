#!/bin/bash

declare -a brew_formulas=(
    # Upgrade default command line tools
    bash
    curl
    git
    wget
    zsh

    # Utilities
    colordiff
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
    flux
    google-chrome
    spotify
)

# Check if directory is writable, if not, take ownership of it
if [ ! -w /usr/local ]; then
    printf "%s\n" "Taking ownership of /usr/local..."
    sudo chown -R "$(whoami)" /usr/local
fi

printf "%s\n" "Updating Homebrew package lists..."
brew update

printf "%s\n" "Upgrading installed packages..."
brew upgrade

printf "%s\n" "Installing Brew formulas..."

# Install Brew formulas, suppress "already installed" warnings
for formula in "${brew_formulas[@]}"; do
    brew install "$formula" 2> /dev/null
done

printf "%s\n" "Installing Brew Cask formulas..."

# Install Cask formulas, suppress "already installed" warnings
for formula in "${cask_formulas[@]}"; do
    brew cask install "$formula" 2> /dev/null
done

printf "%s\n" "Brew done."
