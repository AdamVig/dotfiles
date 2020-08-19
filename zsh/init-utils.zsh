#!/usr/bin/env zsh

# Initialize Zsh utilities.

_dir_init_utils="$(dirname "$(realpath "${(%):-%x}")")"

if "$_dir_init_utils"/../bin/is-macos; then
	source "/usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
elif "$_dir_init_utils"/../bin/is-linux; then
	source "/usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi

z_dir="${XDG_DATA_HOME:-$HOME/.local/share}"/z
if ! [ -d "$z_dir" ]; then
    mkdir -p "$z_dir"
    touch "$z_dir"/z
fi
export _Z_DATA="$z_dir"/z
# Avoid sourcing multiple times by checking fpath
if [[ "$FPATH" != *"zsh-z"* ]]; then
	source "${XDG_DATA_HOME:-$HOME/.local/share}"/zsh-z/zsh-z.plugin.zsh
fi
