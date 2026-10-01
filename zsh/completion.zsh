#!/usr/bin/env zsh

# Initialize command completion.

if [[ $OSTYPE == darwin* ]]; then
	brew_completion_path="$(brew --prefix)"/share/zsh/site-functions
	if [ -d "$brew_completion_path" ] && [[ "$FPATH" != *"$brew_completion_path"* ]]; then
		fpath=("$brew_completion_path" $fpath)
	fi
fi

site_functions_path="${XDG_DATA_HOME:-$HOME/.local/share}"/zsh/site-functions
legacy_site_functions_path="${XDG_DATA_HOME:-$HOME/.local/share}"/zsh-site-functions
if [ -d "$legacy_site_functions_path" ]; then
	# TODO: Remove after all machines have migrated.
	mkdir -p "$site_functions_path" &&
		mv -f "$legacy_site_functions_path"/*(DN) "$site_functions_path"/ &&
		rm -rf "$legacy_site_functions_path"
fi

if [ -d "$site_functions_path" ]; then
	fpath=("$site_functions_path" $fpath)
fi

completion_path=/usr/local/share/zsh/site-functions

if [[ "$FPATH" != *"$completion_path"* ]]; then
  fpath=("$completion_path" $fpath)
fi

zmodload -i zsh/complist

# Initialize completion, ignoring insecure directories and caching for 20 hours
# Copied from Prezto (https://github.com/sorin-ionescu/prezto/tree/master/modules/completion)
autoload -Uz compinit
_comp_path="${XDG_CACHE_HOME:-$HOME/.cache}/zcompdump"
# #q expands globs in conditional expressions
if [[ $_comp_path(#qNmh-20) ]]; then
  # -C (skip function check) implies -i (skip security check)
  compinit -C -d "$_comp_path"
else
  mkdir -p "$_comp_path:h"
  compinit -i -d "$_comp_path"
fi
unset _comp_path

zstyle ':completion:*' menu select

# Enable hyphen-insensitive and case-insensitive completion
# https://github.com/ohmyzsh/ohmyzsh/blob/c47ac2d86d1aec3dcc3106c58d3ef0a91aa8cc3c/lib/completion.zsh#L16-L25
zstyle ':completion:*' matcher-list 'm:{a-zA-Z-_}={A-Za-z_-}' 'r:|=*' 'l:|=* r:|=*'

compdef _git log-branch-commits=git-branch
compdef _git merge-latest=git-branch

compdef _rg ,hyperlinked-ripgrep

if [[ -x "$HOME"/.local/bin/gs ]]; then
	autoload -U +X bashcompinit && bashcompinit
	complete -C "$HOME"/.local/bin/gs gs
fi
