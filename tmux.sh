#!/usr/bin/env bash

DIR="$(dirname "$(realpath "$0")")"

# shellcheck source=./helpers.sh
source "$DIR/helpers.sh"

message "initializing Tmux configuration..."
config_path="$(xdg_config)"/tmux
mkdir -p "$config_path"

if [ -h "$HOME"/.tmux.conf ]; then
	message "  %s" "removing old configuration file..."
	rm -f "$HOME"/.tmux.conf
fi
ln -sf "$DIR"/tmux.conf "$config_path"
message "done initializing Tmux configuration."

message "initializing Tmux Plugin Manager..."
readonly tpm_path="$(xdg_data)"/tmux/plugins/tpm
if ! [ -d "$tpm_path" ]; then
	git clone https://github.com/tmux-plugins/tpm "$tpm_path"
	message "done initializing Tmux Plugin Manager."
else
	message "tmux Plugin Manager already initialized."
fi
