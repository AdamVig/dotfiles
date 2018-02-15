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


message "Linux setup done."