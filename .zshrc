#!/usr/bin/env zsh

_dir_zshrc="$(dirname "$(realpath "${(%):-%x}")")"

# Explicitly source .profile (in a mode compatible with Bash) in case the current shell is not a login shell
BASH_SOURCE=("${(%):-%x}") emulate ksh -c 'source "$HOME"/.profile'

# enable Ctrl+Q shortcut
unsetopt flowcontrol

data_dir="${XDG_DATA_HOME:-$HOME/.local/share}"/zsh
if ! [ -d "$data_dir" ]; then
  mkdir -p "$data_dir"
fi
source "$data_dir"/directories.zsh
source "$data_dir"/key-bindings.zsh
source "$data_dir"/init-completion.zsh
# Depends on completion
source "$data_dir"/git.zsh
source "$data_dir"/init-utils.zsh

# history options (from Oh My Zsh lib/history.zsh)
[ -z "$HISTFILE" ] && HISTFILE="$data_dir"/history
HISTSIZE=50000
SAVEHIST=10000
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

git-wip() {
  if git log --max-count=1 2> /dev/null | grep --quiet "\-\-wip\-\-"; then
    #  <red>[WIP]<end red>
    echo ' %F{red}[WIP]%f'
  fi
}   

git-info() {
  local ref
  # Get ref name, else ref SHA, else return early
  ref="$(command git symbolic-ref --short HEAD 2> /dev/null)" || \
    ref="$(command git rev-parse --short HEAD 2> /dev/null)" || \
    return 0

  # (<ref><maybe wip>)
  echo " ($ref$(git-wip))"
}

# Enable substitution in PS1 (must be single-quoted)
setopt prompt_subst

# <remote host info> <bold><dir, max two levels deep><end bold> <git info>
PS1='$(remote-host-info)%B%2~%b$(git-info) '

source "$data_dir"/aliases.zsh

if [ -f "$HOME"/.wsl ]; then
	source "$HOME"/.wsl
fi

# Load file if exists, suppress error if missing
# shellcheck source=/dev/null
source ~/.locals &> /dev/null || true

# Initialize Nodenv if not already initialized
if [[ "$PATH" != *"nodenv/shims"* ]]; then
  eval "$(nodenv init - --no-rehash)"

	# For Linux
	nodenv_completions_path="$NODENV_ROOT"/completions/nodenv.zsh
	if [ -f "$nodenv_completions_path" ]; then
		source "$nodenv_completions_path"
	fi
fi

# Initialize broot
if "$_dir_zshrc"/bin/is-macos; then
  broot_root='org.dystroy.broot'
else
  broot_root='broot'
fi
# shellcheck disable=SC1090
source "${XDG_CONFIG_HOME:-$HOME/.config}"/"$broot_root"/launcher/bash/br

# If in an interactive session, Tmux is installed, and not in a Tmux pane
if [ -t 1 ] && ! [ -v SSH_TTY ] && command -v tmux > /dev/null && ! [ -v TMUX ]; then
	# Attach to or create a session named "1" with an initial window named "home"
  tmux new-session -A -s 1 -n home
fi
