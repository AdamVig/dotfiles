#!/bin/sh

# Ask for password
sudo -v

# Refresh apt
sudo apt-get update
sudo apt-get upgrade -y

# Install Node.js and npm
sudo apt-get remove --purge node  # Remove old version
curl -sL https://deb.nodesource.com/setup | sudo bash -  # Add repositories
sudo apt-get install -y nodejs
sudo ln -s /usr/bin/nodejs /usr/bin/node  # Make the binary available as just "node"

sudo apt-get install -y python-pip

# Install tools
sudo apt-get install -y emacs
sudo apt-get install -y httpie
sudo apt-get install -y ssh-copy-id
