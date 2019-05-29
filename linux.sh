#!/usr/bin/env bash

DIR="$(dirname "$(realpath "$0")")"
TEMP_DIR="/tmp"

# shellcheck source=./helpers.sh
source "$DIR/helpers.sh"

request-sudo

message "  %s" "setting up Linux..."

message "    %s" "installing essential tools..."
if command -v apt > /dev/null; then
    sudo apt-get update > /dev/null
    sudo apt-get install --yes build-essential curl file git > /dev/null
else
    error "could not find a supported package manager; skipping install"
fi
message "    %s" "done installing essential tools."

if ! command -v brew &> /dev/null; then
    message "    %s" "installing Linuxbrew..."
    set +eu
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"
    set -eu
    message "    %s" "done installing Linuxbrew."
fi

# this will have errors but should at least initialize Linuxbrew
source "$DIR/.bash_profile" &> /dev/null || true

message "  %s" "done setting up Linux."
