#!/usr/bin/env bash

# Get script directory (allows running from outside `dotfiles` dir)
DIR="$( cd "$(dirname "$0")" || return; pwd -P )"

# shellcheck source=./helpers.sh
source "$DIR/helpers.sh"

message "Setting up Git..."
# If gitconfig does not exist already, create one
if [ ! -e ~/.gitconfig ]; then
    message "  %s" "Copying gitconfig to home directory..."
    cp "$DIR/.gitconfig" ~
    
    message "  %s" "Configuring Git..."
    read -r -p "  Full name: " NAME
    read -r -p "  Email address: " EMAIL
    read -r -p "  Github username: " GITHUB

    # Only set values if they are non-empty
    [[ -n "$NAME" ]] && git config --global user.name "$NAME"
    [[ -n "$EMAIL" ]] && git config --global user.email "$EMAIL"
    [[ -n "$GITHUB" ]] && git config --global github.user "$GITHUB"
fi
message "Done setting up Git."
