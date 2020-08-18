#!/usr/bin/env zsh

# Initialize command completion.

completion_path=/usr/local/share/zsh/site-functions

if [[ "$FPATH" != *"$completion_path"* ]]; then
  FPATH="$completion_path${FPATH:+:${FPATH}}"
fi

zmodload -i zsh/complist
autoload -U compinit
compinit -i -d "${XDG_CACHE_HOME:-$HOME/.cache}"/zcompdump

zstyle ':completion:*' menu select

hub_completions_path="${XDG_DATA_HOME:-$HOME/.local/share}"/hub/hub.zsh_completion
if [ -f "$hub_completions_path" ]; then
	source "$hub_completions_path"
fi
