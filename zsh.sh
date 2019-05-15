#!/usr/bin/env bash

# Get script directory (allows running from outside `dotfiles` dir)
DIR="$( cd "$(dirname "$0")" || return; pwd -P )"

# shellcheck source=./helpers.sh
source "$DIR/helpers.sh"

request-sudo

if is-wsl && [[ "$SHELL" != *zsh ]]; then
    message "Changing default shell to Zsh..."
    if ! grep 'zsh' /etc/shells > /dev/null; then
        message "Adding ZSH to /etc/shells..."
        which zsh | sudo tee -a /etc/shells
        message "Done adding ZSH to /etc/shells."
    fi
    chsh --shell "$(which zsh)"
    message "Done changing default shell to Zsh."
fi

message "Initializing Zsh configuration..."
ln -sf "$DIR/.directories.zsh" ~
ln -sf "$DIR/.git.zsh" ~
ln -sf "$DIR/.key-bindings.zsh" ~
ln -sf "$DIR/.zprofile" ~
ln -sf "$DIR/.zshrc" ~
message "Done initializing Zsh configuration."
