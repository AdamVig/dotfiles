#!/usr/bin/env zsh

# Initialize Zsh utilities.

brew_prefix="$(get_brew_prefix)"

source "$brew_prefix/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

z_dir="${XDG_DATA_HOME:-$HOME/.local/share}"/z
if ! [ -d "$z_dir" ]; then
    mkdir -p "$z_dir"
    touch "$z_dir"/z
fi
export _Z_DATA="$z_dir"/z
source "$brew_prefix"/etc/profile.d/z.sh
