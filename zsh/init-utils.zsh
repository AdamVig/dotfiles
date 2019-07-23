#!/usr/bin/env zsh

# Initialize Zsh utilities.

brew_prefix=
if is-macos; then
  brew_prefix='/usr/local'
elif is-linux; then
  brew_prefix='/home/linuxbrew/.linuxbrew'
fi

source "$brew_prefix/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

z_dir="$(xdg_data)"/z
if ! [ -d "$z_dir" ]; then
    mkdir -p "$z_dir"
    touch "$z_dir"/z
fi
export _Z_DATA="$z_dir"/z
source "$brew_prefix"/etc/profile.d/z.sh
