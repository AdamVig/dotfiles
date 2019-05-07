#!/bin/zsh

source $ZSH/oh-my-zsh.sh

source "$HOME"/.git.zsh

# Remove alias for "git remote" so it can be used for Git-run instead
unalias gr

remote-host-info() {
  if [ -n "$SSH_TTY" ] || [ -n "$SSH_CONNECTION" ] || [ -n "$SSH_CLIENT" ]; then
    # <username>@<hostname>
    echo '%n@%M '
  fi
}

git-info() {
  local ref
  # Get ref name, else ref SHA, else return early
  ref="$(command git symbolic-ref --short HEAD 2> /dev/null)" || \
    ref="$(command git rev-parse --short HEAD 2> /dev/null)" || \
    return 0
  # (<ref>)
  echo " ($ref%)"
}

# Enable substitution in PS1 (must be single-quoted)
setopt prompt_subst

# <remote host info> <bold><dir, max two levels deep><end bold> <git info>
PS1='$(remote-host-info)%B%2~%b$(git-info) '

brew_prefix=
if is-macos; then
  brew_prefix='/usr/local'
elif is-linux; then
  brew_prefix='/home/linuxbrew/.linuxbrew'
fi

source "$brew_prefix/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
source "$brew_prefix/etc/profile.d/z.sh"
