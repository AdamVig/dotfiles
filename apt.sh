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
    kdiff3    # Merge tool
    meld    # Comparison tool for version control, files, and directories
    nnn   # Command-line file browser
    jq    # JSON processor
    mosh
    python-pip
    zsh

    # languages
    golang-go
)

message "  %s" "Installing packages..."
for package in "${apt_packages[@]}"; do
    set +e
    # Attempt to install package; log message on success, log warning on failure
    sudo apt-get install -y "$package" &> /dev/null && \
        message "    %s" "Installed $package" || \
        warn "    %s" "package $package failed to install"
    set -e
done
message "  %s" "Done installing packages."

message "Done setting up apt."
