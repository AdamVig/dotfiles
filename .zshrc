#!/usr/bin/env zsh

source "$HOME"/.bash_profile

# completion
zmodload -i zsh/complist
autoload -U compinit
compinit -i -d "${XDG_CACHE_HOME:-"$HOME"/.cache}"/zcompdump

data_dir="${XDG_DATA_HOME:-"$HOME"/.local/share}"/zsh
source "$data_dir"/directories.zsh
source "$data_dir"/key-bindings.zsh
source "$data_dir"/git.zsh

# history options (from Oh My Zsh lib/history.zsh)
setopt extended_history # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups # ignore duplicated commands history list
setopt hist_ignore_space # ignore commands that start with space
setopt hist_verify # show command with history expansion to user before running it
setopt inc_append_history # add commands to HISTFILE in order of execution
setopt share_history # share command history data

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

z_dir="${XDG_DATA_HOME:-"$HOME"/.local/share}"/z
if ! [ -d "$z_dir" ]; then
    mkdir -p "$z_dir"
    touch "$z_dir"/z
fi
export _Z_DATA="$z_dir"/z
source "$brew_prefix"/etc/profile.d/z.sh
