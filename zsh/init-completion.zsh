#!/usr/bin/env zsh

# Initialize command completion.

brew_prefix="$(get_brew_prefix)"
completion_path="$brew_prefix"/share/zsh/site-functions

if [[ "$FPATH" != *"$completion_path"* ]]; then
  FPATH="$completion_path${FPATH:+:${FPATH}}"
fi

zmodload -i zsh/complist
autoload -U compinit
compinit -i -d "$(xdg_cache)"/zcompdump