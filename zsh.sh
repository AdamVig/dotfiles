#!/bin/bash

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

message "Installing Zsh syntax highlighting..."
ZSH_SYNTAX_FOLDER=~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
if [ ! -d "$ZSH_SYNTAX_FOLDER" ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
        "$ZSH_SYNTAX_FOLDER"
fi
message "Done installing Zsh syntax highlighting."

message "Installing custom Zsh theme..."
mkdir -p ~/.oh-my-zsh/custom/themes
ln -sf "$DIR/adamvig.zsh-theme" ~/.oh-my-zsh/custom/themes
message "Done installing custom Zsh theme."

message "Initializing Zsh configuration..."
ln -sf "$DIR/.zshrc" ~
message "Done initializing Zsh configuration."
