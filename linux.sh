#!/bin/bash

# Get script directory (allows running from outside `dotfiles` dir)
DIR="$( cd "$(dirname "$0")" || return; pwd -P )"
TEMP_DIR="/tmp"

# shellcheck source=./helpers.sh
source "$DIR/helpers.sh"

message "  %s" "Setting up Linux..."

message "  %s" "Installing Git Repository Viewer..."

if URL="$(get-release-url rgburke/grv linux64)"; then
    # Download the latest release to a file called "grv" in TEMP_DIR
    wget --quiet --output-document "$TEMP_DIR/grv" "$URL"

    if [[ -f "$TEMP_DIR/grv" ]]; then
        # Move into place
        mv "$TEMP_DIR/grv" /usr/local/bin/grv

        # Set permissions on executable
        chmod -f +x /usr/local/bin/grv

        message "  %s" "Done installing Git Repository Viewer."
    else
        warn "failed to download Git Repository Viewer (using URL $URL)"
    fi
else
    warn "could not install Git Repository Viewer ($URL)"
fi

message "  %s" "Installing fswatch..."
if URL=$(get-release-url emcrisostomo/fswatch tar.gz); then
    # Download the latest release to a file called "fswatch.tar.gz" in TEMP_DIR
    wget --quiet --output-document "$TEMP_DIR/fswatch.tar.gz" "$URL"

    if [[ -f "$TEMP_DIR/fswatch.tar.gz" ]]; then
        cd "$TEMP_DIR" || exit
        tar xf "$TEMP_DIR/fswatch.tar.gz"
        # Filename will change, use a wildcard to cover all possible names
        cd fswatch-*
        ./configure && make && make install
        message "  %s" "Done installing fswatch."
    else
        warn "failed to download fswatch (using URL $URL)"
    fi
else
    warn "could not install fswatch ($URL)"
fi

message "  %s" "Installing nodenv..."
git clone https://github.com/nodenv/nodenv.git ~/.nodenv
cd ~/.nodenv && src/configure && make -C src

# Plugin for installing versions of Node
git clone https://github.com/nodenv/node-build.git "$(nodenv root)"/plugins/node-build

# Plugin for auto-installing list of npm packages
git clone https://github.com/nodenv/nodenv-default-packages.git "$(nodenv root)"/plugins/nodenv-default-packages

# Plugin for auto-rehashing when a global package is installed or uninstalled
git clone https://github.com/nodenv/nodenv-package-rehash.git "$(nodenv root)"/plugins/nodenv-package-rehash
message "  %s" "Done installing nodenv."

message "  %s" "Installing Keybase..."
# See https://keybase.io/docs/the_app/install_linux
cd /tmp || exit
curl -O https://prerelease.keybase.io/keybase_amd64.deb
sudo dpkg -i keybase_amd64.deb
sudo apt-get install -f
run_keybase
cd || exit
message "  %s" "Done installing Keybase."

message "  %s" "Installing Golang Delve debugger..."
go get -u github.com/derekparker/delve/cmd/dlv
message "  %s" "Done installing Golang Delve debugger."

message "  %s" "Linking binaries to their common names..."
# See https://askubuntu.com/a/748059
sudo apt remove -y gnupg
sudo ln -s /usr/bin/gpg2 /usr/bin/gpg
message "  %s" "Done linking binaries."

message "Linux setup done."