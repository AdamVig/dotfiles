#!/usr/bin/env zsh

# Initialize Zsh utilities.

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
# Override length after which Git commit message is highlighted in red
# Default is 50, but GitHub displays up to 72 characters (https://cbea.ms/git-commit/#limit-50)
FAST_HIGHLIGHT[git-cmsg-len]=71

# Enable built-in functions (see man zshcontrib)
autoload zcalc
autoload zmv
