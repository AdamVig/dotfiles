#!/usr/bin/env bash

DIR="$(dirname "$(realpath "$0")")"

# shellcheck source=./helpers.sh
source "$DIR/helpers.sh"

request-sudo

if [[ "$SHELL" != *zsh ]]; then
  message "Changing default shell to Zsh..."
  if is-wsl && ! grep 'zsh' /etc/shells > /dev/null; then
    message "Adding ZSH to /etc/shells..."
    which zsh | sudo tee -a /etc/shells
    message "Done adding ZSH to /etc/shells."
  fi

  if is-macos; then
    sudo chsh -s "$(which zsh)" "$USER"
  else
    chsh --shell "$(which zsh)"
  fi

  message "Done changing default shell to Zsh."
fi

message "Initializing Zsh configuration..."
data_dir="$(xdg_data)/zsh"
if ! [ -d "$data_dir" ]; then
  mkdir -p "$data_dir"
fi
ln -sf "$DIR"/zsh/* "$data_dir"
ln -sf "$DIR"/.zshrc "$HOME"
message "Done initializing Zsh configuration."
