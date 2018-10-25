#!/bin/bash

# Get script directory (allows running from outside `dotfiles` dir)
DIR="$( cd "$(dirname "$0")" || return; pwd -P )"

# shellcheck source=./helpers.sh
source "$DIR/helpers.sh"

# Refresh existing sudo session or start a new one
request-sudo

message "magenta" "Setting up Homebrew..."

if [ ! -f "$(which brew)" ]; then
    message "magenta" "  %s" "Installing Homebrew..."
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Check if directory is writable, if not, take ownership of it
message "magenta" "  %s" "Checking ownership of subdirectories of /usr/local..."
for dir in $(brew --prefix)/*; do
    if [ ! -w "$dir" ]; then
        request-sudo chown -R "$(whoami)" "$dir"
        message "magenta" "    %s" "Took ownership of $dir"
    fi
done

message "magenta" "  %s" "Updating Homebrew package lists..."
brew update &> /dev/null

message "magenta" "  %s" "Updating Brew packages and installing Brew formulas..."

brew bundle --all

message "magenta" "Homebrew done."
