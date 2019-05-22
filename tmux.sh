#!/usr/bin/env bash

DIR="$(dirname "$(realpath "$0")")"

# shellcheck source=./helpers.sh
source "$DIR/helpers.sh"

message "initializing Tmux configuration..."
config_path="${XDG_CONFIG_HOME:-"$HOME"/.config}/tmux"
mkdir -p "$config_path"

if [ -h "$HOME"/.tmux.conf ]; then
  message "  %s" "removing old configuration file..."
  rm -f "$HOME"/.tmux.conf
fi
ln -sf "$DIR"/tmux.conf "$config_path"
message "done initializing Tmux configuration."

message "initializing Tmux Plugin Manager..."
readonly tpm_path="$HOME/.tmux/plugins/tpm"
if ! [ -d "$tpm_path" ]; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  message "done initializing Tmux Plugin Manager."
else
  message "Tmux Plugin Manager already initialized."
fi
