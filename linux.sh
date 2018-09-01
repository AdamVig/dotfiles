#!/bin/bash

# Get script directory (allows running from outside `dotfiles` dir)
DIR="$( cd "$(dirname "$0")" || return; pwd -P )"
TEMP_DIR="/tmp"

# shellcheck source=./helpers.sh
source "$DIR/helpers.sh"

message "  %s" "Setting up Linux..."

message "  %s" "Installing Bat..."

if URL="$(get-release-url sharkdp/bat amd64)"; then
    # Download the latest release to TEMP_DIR
    wget --quiet --output-document "$TEMP_DIR/bat.deb" "$URL"

    if [[ -f "$TEMP_DIR/bat" ]]; then
        # Install
	sudo dpkg -i "$TEMP_DIR/bat.deb"

        message "  %s" "Done installing Bat."
    else
        warn "failed to download Bat (using URL $URL)"
    fi
else
    warn "could not install Bat ($URL)"
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
request-sudo dpkg -i keybase_amd64.deb
request-sudo apt-get install -f
run_keybase
cd || exit
message "  %s" "Done installing Keybase."

message "  %s" "Installing Golang Delve debugger..."
go get -u github.com/derekparker/delve/cmd/dlv
message "  %s" "Done installing Golang Delve debugger."

message "  %s" "Linking binaries to their common names..."
# See https://askubuntu.com/a/748059
request-sudo apt remove -y gnupg
request-sudo ln -s /usr/bin/gpg2 /usr/bin/gpg
message "  %s" "Done linking binaries."

message "Linux setup done."
