#!/bin/bash

# Get script directory (allows running from outside `dotfiles` dir)
DIR="$( cd "$(dirname "$0")" || return; pwd -P )"

MAGENTA="35"

source "$DIR/helpers.sh"

# Refresh existing sudo session or start a new one
sudo --validate

message "Setting up Homebrew..." "$MAGENTA"

declare -a brew_formulas=(
    # Upgrade default command line tools
    bash
    curl
    git
    gpg
    wget
    zsh

    # Utilities
    colordiff
    emacs
    grv    # Git Repository Viewer
    hub
    jq    # JSON processor
    markdown
    mobile-shell
    nodenv    # Node environment manager
    nodenv/nodenv/nodenv-default-packages    # Plugin for auto-installing list of npm packages
    nodenv/nodenv/nodenv-package-rehash    # Plugin for auto-rehashing when a global package is installed or uninstalled
    shellcheck    # Shell script linter
    ssh-copy-id
    z

    # Languages
    golang
    python
    python3
)

declare -a cask_formulas=(
    # applications
    firefox
    google-chrome
    gpg-suite    # Add GPG keys to macOS Keychain
    kap    # Screen recorder
    keybase
    lastpass
    qlmarkdown    # Markdown rendering in Finder quick look
    signal    # Encrypted messaging
    sketch
    spectacle    # Window manager
    spotify
    standard-notes
    visual-studio-code

    # fonts
    font-blokk-neue
    font-fira-code
    font-lato
    font-noto-sans
    font-open-sans
    font-source-code-pro

    # drivers
    logitech-options
)

if [ ! -f "$(which brew)" ]; then
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
brew upgrade 1> /dev/null

message "  Installing Brew formulas..." "$MAGENTA"

# Install Brew formulas, suppress "already installed" warnings
for formula in "${brew_formulas[@]}"; do
    brew install "$formula" &> /dev/null && \
        message "    Installed $formula" "$MAGENTA" || \
        warn "formula $formula failed to install"
done

message "  Installing Brew Cask formulas..." "$MAGENTA"

# Install Cask formulas, suppress "already installed" warnings
for formula in "${cask_formulas[@]}"; do
    brew cask install "$formula" &> /dev/null && \
        message "    Installed $formula" "$MAGENTA" || \
        warn "formula $formula failed to install"
done

message "Homebrew done." "$MAGENTA"

message "Run '/usr/local/Caskroom/lastpass/latest/LastPass Installer/LastPass Installer.app' to install the LastPass browser extension." "$MAGENTA"
