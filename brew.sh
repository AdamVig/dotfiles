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
    hub
    markdown
    mobile-shell
    ssh-copy-id
    z

    # Languages
    node
    python
    python3
)

declare -a cask_formulas=(
    emacs
    google-chrome
    iterm2
    qlmarkdown    # Markdown rendering in Finder quick look
    spotify
    visual-studio-code
)

declare -a cask_font_formulas=(
    font-fira-code
    font-lato
    font-noto-sans
    font-open-sans
    font-source-code-pro
)

if [ ! -f "`which brew`" ]; then
    printf "%s\n" "Installing Homebrew..."
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

    printf "%s\n" "Tapping caskroom/fonts..."
    brew tap caskroom/fonts
fi

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

printf "%s\n" "Installing Brew Cask font formulas..."

# Install Cask font formulas, suppress "already installed" warnings
for formula in "${cask_font_formulas[@]}"; do
    brew cask install "$formula" 2> /dev/null
done

printf "%s\n" "Brew done."
