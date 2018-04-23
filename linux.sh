#!/bin/bash

# Get script directory (allows running from outside `dotfiles` dir)
DIR="$( cd "$(dirname "$0")" || return; pwd -P )"

source "$DIR/helpers.sh"

message "Setting up Linux..."

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

# Plugin for installing versions of Node
git clone https://github.com/nodenv/node-build.git "$(nodenv root)"/plugins/node-build

# Plugin for auto-installing list of npm packages
git clone https://github.com/nodenv/nodenv-default-packages.git "$(nodenv root)"/plugins/nodenv-default-packages

# Plugin for auto-rehashing when a global package is installed or uninstalled
git clone https://github.com/nodenv/nodenv-package-rehash.git "$(nodenv root)"/plugins/nodenv-package-rehash
message "Done installing nodenv."

message "Installing Keybase..."
# See https://keybase.io/docs/the_app/install_linux
cd /tmp || exit
curl -O https://prerelease.keybase.io/keybase_amd64.deb
sudo dpkg -i keybase_amd64.deb
sudo apt-get install -f
run_keybase
cd || exit
message "Done installing Keybase."

message "Installing Golang Delve debugger..."
go get -u github.com/derekparker/delve/cmd/dlv
message "Done installing Golang Delve debugger."

message "Linking binaries to their common names..."
# See https://askubuntu.com/a/748059
sudo apt remove -y gnupg
sudo ln -s /usr/bin/gpg2 /usr/bin/gpg
message "Done linking binaries."

message "Linux setup done."