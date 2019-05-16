#!/usr/bin/env bash

DIR="$(dirname "$(realpath "$0")")"

# shellcheck source=./helpers.sh
source "$DIR/helpers.sh"

message "Setting up apt..."

message "Adding apt repositories..."
curl -s https://updates.signal.org/desktop/apt/keys.asc | request-sudo apt-key add -
signal_apt_repository='deb [arch=amd64] https://updates.signal.org/desktop/apt xenial main'
if grep --quiet "$signal_apt_repository" /etc/apt/sources.list.d/signal-xenial.list; then
    echo "$signal_apt_repository" | request-sudo tee -a /etc/apt/sources.list.d/signal-xenial.list
fi
message "Done adding apt repositories."

# Refresh apt
request-sudo apt-get update > /dev/null
request-sudo apt-get upgrade -y > /dev/null

declare -a apt_packages=(
    # applications
    signal-desktop
    thunderbird

    # tools
    kdiff3    # Merge tool
    meld    # Comparison tool for version control, files, and directories

    # command-line utilities
    mosh # Mobile shell
)

message "  %s" "Installing packages..."
for package in "${apt_packages[@]}"; do
    set +e
    # Attempt to install package; log message on success, log warning on failure
    request-sudo apt-get install -y "$package" > /dev/null && \
        message "    %s" "Installed $package" || \
        warn "package $package failed to install"
    set -e
done
message "  %s" "Done installing packages."

message "  %s" "Installing Keybase..."
wget --quiet --output-document /tmp/keybase.deb https://prerelease.keybase.io/keybase_amd64.deb
if [ -f /tmp/keybase.deb ]; then
    sudo dpkg -i /tmp/keybase.deb &> /dev/null || true
    sudo apt-get --fix-broken -y install
    run_keybase
    message "  %s" "Done installing Keybase."
else
    error "Failed to install Keybase."
fi
    
message "Done setting up apt."
