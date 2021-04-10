#!/usr/bin/env zsh

# Initialize command completion.

completion_path=/usr/local/share/zsh/site-functions

if [[ "$FPATH" != *"$completion_path"* ]]; then
  fpath=("$completion_path" $fpath)
fi

hub_completion_path="${XDG_DATA_HOME:-$HOME/.local/share}"/hub
if [ -d "$hub_completion_path" ] && [[ "$FPATH" != *"$hub_completion_path"* ]]; then
	fpath=("$hub_completion_path" $fpath)
fi

gh_completion_path="${XDG_DATA_HOME:-$HOME/.local/share}"/gh
if [ -d "$gh_completion_path" ] && [[ "$FPATH" != *"$gh_completion_path"* ]]; then
	fpath=("$gh_completion_path" $fpath)
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

compdef _git log-branch-commits=git-branch
