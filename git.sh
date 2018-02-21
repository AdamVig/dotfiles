#!/bin/bash

# Get script directory (allows running from outside `dotfiles` dir)
DIR="$( cd "$(dirname "$0")" ; pwd -P )"

source "$DIR/helpers.sh"

message "Configuring git..."
# If gitconfig does not exist already, create one
if [ ! -e ~/.gitconfig ]; then
    message "  Copying gitconfig to home directory..."
    cp "$DIR/.gitconfig" ~
    
    message "  Configuring Git..."
    read -p "  Full name: " NAME
    read -p "  Email address: " EMAIL
    read -p "  Github username: " GITHUB

    # Only set values if they are non-empty
    [[ -n "$NAME" ]] && git config --global user.name "$NAME"
    [[ -n "$EMAIL" ]] && git config --global user.email "$EMAIL"
    [[ -n "$GITHUB" ]] && git config --global github.user "$GITHUB"
fi