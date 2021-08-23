#!/usr/bin/env zsh

# Configure history.
# From Oh My Zsh lib/history.zsh

data_dir="${XDG_DATA_HOME:-$HOME/.local/share}"/zsh

[ -z "$HISTFILE" ] && HISTFILE="$data_dir"/history
HISTSIZE=50000
SAVEHIST=10000
setopt extended_history # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups # ignore duplicated commands history list
setopt hist_ignore_space # ignore commands that start with space
setopt hist_verify # show command with history expansion to user before running it
setopt inc_append_history # add commands to HISTFILE in order of execution
setopt share_history # share command history data
