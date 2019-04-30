#!/bin/zsh

ZSH_THEME="adamvig"

plugins=(
    git
    z
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# Remove alias for "git remote" so it can be used for Git-run instead
unalias gr
