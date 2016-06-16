#!/bin/sh

# Ask for password
sudo -v

# Refresh apt
sudo apt-get update
sudo apt-get upgrade -y

# Install Node.js and npm
sudo apt-get remove --purge node  # Remove old version if installed
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -  # Add repo
sudo apt-get install -y nodejs
sudo apt-get install -y npm
sudo ln -s /usr/bin/nodejs /usr/bin/node  # Make the binary available as "node"

# Configure npm global package directory
mkdir ~/.npm-global
npm config set prefix '~/.npm-global'

sudo apt-get install -y python-pip

# Install tools
sudo apt-get install -y emacs
sudo apt-get install -y httpie
sudo apt-get install -y mosh
sudo apt-get install -y zsh
