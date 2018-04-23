#!/bin/bash

message "Setting up apt..."

message "Adding apt repositories..."
curl -s https://updates.signal.org/desktop/apt/keys.asc | sudo apt-key add -
echo "deb [arch=amd64] https://updates.signal.org/desktop/apt xenial main" | sudo tee -a /etc/apt/sources.list.d/signal-xenial.list
message "Done adding apt repositories."

# Refresh apt
sudo apt-get update
sudo apt-get upgrade -y


declare -a apt_packages=(
    # applications
    signal-desktop   # Encrypted messaging

    # tools
    emacs
    gnupg2
    httpie
    jq    # JSON processor
    mosh
    python-pip
    zsh

    # languages
    golang-go
)

message "  Installing packages..."
for package in "${apt_packages[@]}"; do
    set +e
    # Attempt to install package; log message on success, log warning on failure
    sudo apt-get install -y "$package" &> /dev/null && \
        message "    Installed $package" || \
        warn "package $package failed to install"
    set -e
done
message "  Done installing packages."

message "Done setting up apt."