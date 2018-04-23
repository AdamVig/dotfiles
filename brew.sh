#!/bin/bash

# Get script directory (allows running from outside `dotfiles` dir)
DIR="$( cd "$(dirname "$0")" || return; pwd -P )"

MAGENTA="35"

source "$DIR/helpers.sh"

# Refresh existing sudo session or start a new one
sudo --validate

message "Setting up Homebrew..." "$MAGENTA"

if [ ! -f "$(which brew)" ]; then
    message "  Installing Homebrew..." "$MAGENTA"
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

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

message "  Updating Brew packages and installing Brew formulas..." "$MAGENTA"

brew bundle --all

message "Homebrew done." "$MAGENTA"

message "Run '/usr/local/Caskroom/lastpass/latest/LastPass Installer/LastPass Installer.app' to install the LastPass browser extension." "$MAGENTA"
