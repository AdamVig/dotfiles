#!/bin/sh

message "Setting up apt..."

# Refresh apt
sudo apt-get update
sudo apt-get upgrade -y

declare -a apt_packages=(
    # tools
    emacs
    httpie
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