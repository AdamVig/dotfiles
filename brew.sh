#!/bin/bash

# Get script directory (allows running from outside `dotfiles` dir)
DIR="$( cd "$(dirname "$0")" || return; pwd -P )"

# shellcheck source=./helpers.sh
source "$DIR/helpers.sh"

# Refresh existing sudo session or start a new one
request-sudo

message "magenta" "  %s" "Updating Brew package lists..."
brew update > /dev/null

message "magenta" "  %s" "Installing Brew formulas..."
if ! brew bundle install; then
    warn "installing Brew formulas may have failed"
fi

if is-macos; then
    brew bundle install --file "$DIR/Brewfile-macos"
fi

message "magenta" "Brew done."
