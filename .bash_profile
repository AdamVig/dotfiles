#!/usr/bin/env bash

# shellcheck source=.exports
source ~/.exports

# shellcheck source=.bashrc
source ~/.bashrc

# shellcheck source=.aliases
source ~/.aliases

# shellcheck source=.functions
source ~/.functions

# Load file if exists, suppress error if missing
# shellcheck source=/dev/null
source ~/.locals &> /dev/null || true

# Initialize Linuxbrew if it exists
if [ -d /home/linuxbrew/.linuxbrew ]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

if is-wsl; then
  # https://github.com/Microsoft/WSL/issues/352
  umask 022
fi

# Initialize Nodenv
eval "$(nodenv init -)"

# Temporary override to get rid of mysterious NODE_ENV=production
unset NODE_ENV

if command -v tmux > /dev/null && ! [ -v TMUX ]; then
  tmux
fi
