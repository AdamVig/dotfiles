# Create command aliases.

# Run an npm script without excessive npm output
alias npr='npm run --silent'

alias glb="log-branch-commits"

# Use custom config file location
alias tmux='tmux -f "${XDG_CONFIG_HOME:-$HOME/.config}"/tmux/tmux.conf'

# Must use . to allow the script to change the shell's directory
alias zn='. z-name-tmux-pane'

alias e='emacsclient --create-frame --no-wait'
alias et='emacsclient --tty'

if command -v exa > /dev/null; then
  alias ls='exa'
fi
