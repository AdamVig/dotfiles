#!/usr/bin/env bash

# This script must run after the OS-specific scripts because it depends on Nodenv.

# Get script directory (allows running from outside `dotfiles` dir)
DIR="$( cd "$(dirname "$0")" || return; pwd -P )"

# shellcheck source=./helpers.sh
source "$DIR/helpers.sh"

# Get script directory (allows running from outside `dotfiles` dir)
DIR="$( cd "$(dirname "$0")" || return; pwd -P )"

message "Setting up Node..."

message "  %s" "Copying default packages file..."
cp "$DIR/npm-default-packages" "$(nodenv root)/default-packages" &> /dev/null || true

# 1. Get list of Node versions
# 2. Filter to only get normal Node versions, like "  9.5.0"
# 3. Take last line of output which will be latest version
# 4. Remove the leading spaces
latest_node_version="$(nodenv install --list | grep '^\s\s[0-9]' | tail -1 | xargs)"
if [ -n "$latest_node_version" ]; then
    message "  %s" "Installing Node $latest_node_version and default npm packages..."
    nodenv install --force "$latest_node_version" &> /dev/null || true
    nodenv global "$latest_node_version" &> /dev/null
    message "  %s" "Done installing Node and default npm packages."
else
    warn "  %s" "could not get latest Node version; installation failed"
fi

message "  %s" "Initializing npm-merge-driver..."
npx npm-merge-driver install --global
message "  %s" "Done initializing npm-merge-driver."

message "Done setting up Node."
