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
source "$ZDOTDIR"/utils.zsh
source "$ZDOTDIR"/history.zsh

remote-host-info() {
  if [[ -v SSH_TTY || -v SSH_CONNECTION || -v SSH_CLIENT ]]; then
    # <username>@<hostname>
    echo '%n@%M '
  fi
}

in-dev-container() {
  if [[ -v VSCODE_REMOTE_CONTAINERS_SESSION || -v REMOTE_CONTAINERS || -v IN_DEV_CONTAINER ]]; then
    # <yellow>[Dev Container]<end yellow>
    echo '%F{yellow}[Dev Container]%f '
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

# <in dev container><remote host info> <bold><dir, max two levels deep><end bold> <git info>
PS1='$(in-dev-container)$(remote-host-info)%B%2~%b$(git-info) '

source "$ZDOTDIR"/aliases.zsh

# Initialize fnm if not already initialized
if command -v fnm >/dev/null && [[ "$PATH" != *"fnm"* ]]; then
	eval "$(fnm env --shell=zsh --use-on-cd --version-file-strategy=recursive)"
fi

# Load file if exists, suppress error if missing
# shellcheck source=/dev/null
source ~/.locals &> /dev/null || true

# Initialize Kitty shell integration
if [ -n "$KITTY_INSTALLATION_DIR" ]; then
	autoload -Uz -- "$KITTY_INSTALLATION_DIR"/shell-integration/zsh/kitty-integration
  kitty-integration
  unfunction kitty-integration
fi

# Start Emacs server in Dev Container (Systemd unit not present)
if [[ -v VSCODE_REMOTE_CONTAINERS_SESSION || -v REMOTE_CONTAINERS || -v IN_DEV_CONTAINER ]] && \
	(( $+commands[emacsclient] )); then
  emacsclient -e t >/dev/null 2>&1 || \
    ( mkdir -p ~/.cache && flock --nonblock ~/.cache/emacs-daemon.lock emacs --daemon >/dev/null 2>&1 &! )
fi
