#!/bin/bash

source helpers.sh

message "Setting up Linux..."

message "Installing Node.js and npm"

# Install Node.js and npm
sudo apt-get remove --purge node  # Remove old version if installed
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
sudo apt-get install -y nodejs
sudo ln -s /usr/bin/nodejs /usr/bin/node  # Make the binary available as "node"

# Configure npm global package directory
mkdir ~/.npm-global
npm config set prefix '~/.npm-global'

message "Done installing Node.js and npm."

message "Installing Git Repository Viewer..."

# Check if jq is available for JSON parsing
if command -v jq; then
    # Get URL of latest release from Github API
    URL=$(
        curl -s https://api.github.com/repos/rgburke/grv/releases/latest | \
        jq --raw-output '.assets[] | .browser_download_url | select(endswith("linux64"))'
    )
    # Download the latest release to a file called "grv" in /tmp
    wget --directory-prefix /tmp --output-document grv "$URL"

    # Move into place
    mv /tmp/grv /usr/local/bin/grv

    # Set permissions on executable
    chmod +x /usr/local/bin/grv
fi

message "Done installing Git Repository Viewer."

message "Installing nodenv..."
git clone https://github.com/nodenv/nodenv.git ~/.nodenv
cd ~/.nodenv && src/configure && make -C src

# Install node-build to enable 'nodenv install' functionality
git clone https://github.com/nodenv/node-build.git $(nodenv root)/plugins/node-build
message "Done installing nodenv."

message "Linux setup done."