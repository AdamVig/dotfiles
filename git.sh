#!/usr/bin/env bash

DIR="$(dirname "$(realpath "$0")")"

# shellcheck source=./helpers.sh
source "$DIR/helpers.sh"

# shellcheck source=./.exports
source "$DIR"/.exports

config_path="${XDG_CONFIG_HOME:-"$HOME"/.config}/git"

if [ -e "$HOME"/.gitconfig ]; then
  message "Migrating to new configuration file location..."
  mkdir -p "$config_path"
  mv "$HOME"/.gitconfig "$config_path"/config
fi

message "Setting up Git..."
# If gitconfig does not exist already, create one
if [ ! -e "$config_path"/config ]; then
    message "  %s" "Copying gitconfig to '$config_path/config'..."
    cp "$DIR"/.gitconfig "$config_path"/config
    
    message "  %s" "Configuring Git..."
    read -r -p "  Full name: " NAME
    read -r -p "  Email address: " EMAIL
    read -r -p "  Github username: " GITHUB

    # Only set values if they are non-empty
    [ -n "$NAME" ] && git config --global user.name "$NAME"
    [ -n "$EMAIL" ] && git config --global user.email "$EMAIL"
    [ -n "$GITHUB" ] && git config --global github.user "$GITHUB"

    if "$DIR"/bin/is-wsl; then
      git config --global credential.helper \
        '/mnt/c/Program\ Files/Git/mingw64/libexec/git-core/git-credential-manager.exe'
    fi
fi
message "Done setting up Git."
