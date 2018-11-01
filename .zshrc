#!/bin/zsh

ZSH_THEME="adamvig"

plugins=(
    git
    ng
    npm
    python
    z
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# Remove alias for "Git remote" so it can be used for Git-run instead
unalias gr
