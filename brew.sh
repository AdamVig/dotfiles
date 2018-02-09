#!/bin/bash

MAGENTA="\e[35m"

source helpers.sh

message "Setting up Homebrew..." "$MAGENTA"

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
    nodenv    # Node environment manager
    ssh-copy-id
    z

    # Languages
    golang
    node
    python
    python3
)

declare -a cask_formulas=(
    firefox
    google-chrome
    iterm2
    kap    # Screen recorder
    lastpass
    qlmarkdown    # Markdown rendering in Finder quick look
    sketch
    spectacle    # Window manager
    spotify
    standard-notes
    visual-studio-code
)

declare -a cask_font_formulas=(
    font-blokk-neue
    font-fira-code
    font-lato
    font-noto-sans
    font-open-sans
    font-source-code-pro
)

declare -a cask_driver_formulas=(
    logitech-options
)

if [ ! -f "`which brew`" ]; then
    message "  Installing Homebrew..." "$MAGENTA"
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

message "  Tapping caskroom/fonts..." "$MAGENTA"
brew tap caskroom/fonts &> /dev/null
message "  Tapping caskroom/drivers..." "$MAGENTA"
brew tap caskroom/drivers &> /dev/null

# Check if directory is writable, if not, take ownership of it
message "  Checking ownership of subdirectories of /usr/local..." "$MAGENTA"
for dir in $(brew --prefix)/*; do
    if [ ! -w "$dir" ]; then
        sudo chown -R "$(whoami)" "$dir"
        message "    Took ownership of $dir" "$MAGENTA"
    fi
done

message "  Updating Homebrew package lists..." "$MAGENTA"
brew update &> /dev/null

message "  Upgrading installed packages..." "$MAGENTA"
brew upgrade &> /dev/null

message "  Installing Brew formulas..." "$MAGENTA"

# Install Brew formulas, suppress "already installed" warnings
for formula in "${brew_formulas[@]}"; do
    brew install "$formula" &> /dev/null
    message "    Installed $formula" "$MAGENTA"
done

message "  Installing Brew Cask formulas..." "$MAGENTA"

# Install Cask formulas, suppress "already installed" warnings
for formula in "${cask_formulas[@]}"; do
    brew cask install "$formula" &> /dev/null
    message "    Installed $formula" "$MAGENTA"
done

message "  Installing Brew Cask font formulas..." "$MAGENTA"

# Install Cask font formulas, suppress "already installed" warnings
for formula in "${cask_font_formulas[@]}"; do
    brew cask install "$formula" &> /dev/null
    message "    Installed $formula" "$MAGENTA"
done

message "  Installing Brew driver formulas..." "$MAGENTA"

# Install driver formulas, suppress "already installed" warnings
for formula in "${cask_driver_formulas[@]}"; do
    brew cask install "$formula" &> /dev/null
    message "    Installed $formula" "$MAGENTA"
done

message "Homebrew done." "$MAGENTA"

message "Run '/usr/local/Caskroom/lastpass/latest/LastPass Installer/LastPass Installer.app' to install the LastPass browser extension." "$MAGENTA"
