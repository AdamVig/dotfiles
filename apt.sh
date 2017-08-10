#!/bin/sh

# Refresh apt
sudo apt-get update
sudo apt-get upgrade -y

# Install Node.js and npm
sudo apt-get remove --purge node  # Remove old version if installed
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
sudo apt-get install -y nodejs
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

# Install languages
sudo apt-get install -y golang-go