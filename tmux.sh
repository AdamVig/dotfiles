#!/usr/bin/env bash

# Get script directory (allows running from outside `dotfiles` dir)
DIR="$( cd "$(dirname "$0")" || return; pwd -P )"

# shellcheck source=./helpers.sh
source "$DIR/helpers.sh"

message "Initializing Tmux configuration..."
ln -sf "$DIR/.tmux.conf" ~
message "Done initializing Tmux configuration."

message "Initializing Tmux Plugin Manager..."
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
message "Done initializing Tmux Plugin Manager."
