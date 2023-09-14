#!/usr/bin/env zsh

# Explicitly source .profile (in a mode compatible with Bash) in case the current shell is not a login shell
emulate ksh -c 'source "$HOME"/.profile'

# enable Ctrl+Q shortcut
unsetopt flowcontrol

source "$ZDOTDIR"/directories.zsh
source "$ZDOTDIR"/key-bindings.zsh
source "$ZDOTDIR"/completion.zsh
source "$ZDOTDIR"/fzf.zsh # Depends on completion
source "$ZDOTDIR"/git.zsh # Depends on completion
source "$ZDOTDIR"/yarn.zsh
source "$ZDOTDIR"/utils.zsh
source "$ZDOTDIR"/history.zsh

remote-host-info() {
  if [ -v SSH_TTY ] || [ -v SSH_CONNECTION ] || [ -v SSH_CLIENT ]; then
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

source "$ZDOTDIR"/aliases.zsh

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

# Initialize Kitty shell integration
if [ -n "$KITTY_INSTALLATION_DIR" ]; then
	autoload -Uz -- "$KITTY_INSTALLATION_DIR"/shell-integration/zsh/kitty-integration
  kitty-integration
  unfunction kitty-integration
fi
