#!/usr/bin/env zsh

# Initialize command completion.

completion_path=/usr/local/share/zsh/site-functions

if [[ "$FPATH" != *"$completion_path"* ]]; then
  fpath=("$completion_path" $fpath)
fi

hub_completion_path="${XDG_DATA_HOME:-$HOME/.local/share}"/hub/hub.zsh_completion
if [ -f "$hub_completion_path" ] && [[ "$FPATH" != *"$hub_completion_path"* ]]; then
	fpath=("$hub_completion_path" $fpath)
fi

gh_completion_path="${XDG_DATA_HOME:-$HOME/.local/share}"/gh/gh.zsh_completion
if [ -f "$gh_completion_path" ] && [[ "$FPATH" != *"$gh_completion_path"* ]]; then
	fpath=("$gh_completion_path" $fpath)
fi

if command -v hass-cli >/dev/null; then
	source <(hass-cli completion zsh)
fi

zmodload -i zsh/complist
autoload -U compinit
compinit -i -d "${XDG_CACHE_HOME:-$HOME/.cache}"/zcompdump

zstyle ':completion:*' menu select

compdef _git log-branch-commits=git-branch
