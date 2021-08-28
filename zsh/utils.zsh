#!/usr/bin/env zsh

# Initialize Zsh utilities.

_dir_init_utils="$(dirname "$(realpath "${(%):-%x}")")"

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

source "${XDG_DATA_HOME:-$HOME/.local/share}"/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

# Enable built-in functions (see man zshcontrib)
autoload zcalc
autoload zmv

# Initialize broot
if [[ $OSTYPE == darwin* ]]; then
  broot_root='org.dystroy.broot'
else
  broot_root='broot'
fi
# shellcheck disable=SC1090
source "${XDG_CONFIG_HOME:-$HOME/.config}"/"$broot_root"/launcher/bash/br
