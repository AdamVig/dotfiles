#!/usr/bin/env bash

# Get script directory (allows running from outside `dotfiles` dir)
DIR="$( cd "$(dirname "$0")" || return; pwd -P )"

# shellcheck source=./helpers.sh
source "$DIR/helpers.sh"

message "initializing Tmux configuration..."
ln -sf "$DIR/.tmux.conf" ~
message "done initializing Tmux configuration."

message "initializing Tmux Plugin Manager..."
readonly tpm_path="$HOME/.tmux/plugins/tpm"
if ! [ -d "$tpm_path" ]; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  message "done initializing Tmux Plugin Manager."
else
  message "Tmux Plugin Manager already initialized."
fi
