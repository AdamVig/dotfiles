#!/bin/zsh

plugins=(
    git
    z
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# Remove alias for "git remote" so it can be used for Git-run instead
unalias gr

remote-host-info() {
  if [ -n "$SSH_TTY" ] || [ -n "$SSH_CONNECTION" ] || [ -n "$SSH_CLIENT" ]; then
    # <username>@<hostname>
    echo '%n@%M '
  fi
}

# <remote host info> <bold><dir, max two levels deep><end bold>
export PS1="$(remote-host-info)%B%2~%b "
