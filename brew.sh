#!/usr/bin/env bash

DIR="$(dirname "$(realpath "$0")")"

# shellcheck source=./helpers.sh
source "$DIR/helpers.sh"

# Refresh existing sudo session or start a new one
request-sudo

message "magenta" "  %s" "Updating Brew package lists..."
brew update > /dev/null

message "magenta" "  %s" "Installing Brew formulas..."
if ! brew bundle install --no-lock; then
    warn "installing Brew formulas may have failed"
fi

if "$DIR"/bin/is-macos && brew services list | grep --quiet --extended-regexp 'emacs .+ stopped'; then
    message "magenta" "  %s" "Enabling Emacs service..."
    if brew services start emacs; then
        message "magenta" "  %s" "Enabled Emacs service."
    else
        warn "Failed to enable Emacs service."
    fi
fi

message "magenta" "Brew done."
