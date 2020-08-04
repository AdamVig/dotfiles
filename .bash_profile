#!/usr/bin/env bash

_dir_bash_profile="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"

# Clear out path to prevent reordering in Tmux (https://superuser.com/a/583502/201849)
if [ -f /etc/profile ] && [[ "$OSTYPE" == darwin* ]]; then
	# shellcheck disable=SC2123
  PATH=""
  source /etc/profile
fi

# Run an npm script without excessive npm output
alias npr='npm run --silent'

alias glb="log-branch-commits"

# Use custom config file location
alias tmux='tmux -f "${XDG_CONFIG_HOME:-$HOME/.config}"/tmux/tmux.conf'

# Must use . to allow the script to change the shell's directory
alias zn='. z-name-tmux-pane'

if "$_dir_bash_profile"/bin/is-wsl; then
  alias kdiff3='kdiff3.exe'
  alias meld='meld.exe'
	# shellcheck disable=SC2139
  alias open="$_dir_bash_profile"/bin/wsl-open
fi

if command -v exa > /dev/null; then
  alias ls='exa'
fi

# Load file if exists, suppress error if missing
# shellcheck source=/dev/null
source ~/.locals &> /dev/null || true

# Initialize Linuxbrew if it exists and is not already initialized
if [ -d /home/linuxbrew/.linuxbrew ] && [[ "$PATH" != *"/home/linuxbrew/.linuxbrew/bin"* ]]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# Initialize Nodenv if not already initialized
if [[ "$PATH" != *"nodenv/shims"* ]]; then
  # Prevent Nodenv from storing data in ~/.nodenv
  export NODENV_ROOT="${XDG_DATA_HOME:-$HOME/.local/share}"/nodenv

  eval "$(nodenv init -)"
fi

# Temporary override to get rid of mysterious DOCKER_HOST on WSL
unset DOCKER_HOST

# Source exports late so that PATH overrides take effect
# shellcheck source=.exports
source ~/.exports

# shellcheck source=.bashrc
source ~/.bashrc

if is-wsl; then
  # https://github.com/Microsoft/WSL/issues/352
  umask 022
fi

# Initialize broot
if is-macos; then
  broot_root='org.dystroy.broot'
else
  broot_root='broot'
fi
# shellcheck disable=SC1090
source "${XDG_CONFIG_HOME:-$HOME/.config}"/"$broot_root"/launcher/bash/br

# If in an interactive session, Tmux is installed, and not in a Tmux pane
if [ -t 1 ] && command -v tmux > /dev/null && ! [ -v TMUX ]; then
  tmux attach || tmux new
fi
