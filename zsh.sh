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

message "Installing Oh My Zsh..."
if ! [ -d ~/.oh-my-zsh ]; then
    url=https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh
    if ! sh -c "$(curl -fsSL "$url")"; then
        warn "Oh My ZSH installation failed"
        exit
    else
        message "Done installing Oh My Zsh."
    fi
fi

message "Initializing Zsh configuration..."
ln -sf "$DIR/.git.zsh" ~
ln -sf "$DIR/.zprofile" ~
ln -sf "$DIR/.zshrc" ~
message "Done initializing Zsh configuration."
