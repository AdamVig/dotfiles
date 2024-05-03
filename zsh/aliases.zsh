# Create command aliases.

alias b='bat'

# Highlight help messages with bat
alias -g -- -h='-h 2>&1 | bat --language=help --style=plain'
alias -g -- --help='--help 2>&1 | bat --language=help --style=plain'

# Run an npm script without excessive npm output
alias npr='npm run --silent'

alias glb="log-branch-commits"

# Display image in terminal
alias icat='kitty +kitten icat'

# Prevent wget from storing HSTS database in home directory
alias wget='wget --hsts-file="${XDG_CACHE_HOME:-$HOME/.cache}"/wget-hsts'

# Prevent units from storing history file in home directory
alias units='units --history="${XDG_CACHE_HOME:-$HOME/.cache}"/units_history'

alias et='emacsclient --tty'
alias e='emacsclient --create-frame --no-wait'

if command -v eza > /dev/null; then
  alias ls='eza --hyperlink'
fi

if [[ "$OSTYPE" = *linux* ]]; then
	# Show webcam feed locally (https://github.com/mpv-player/mpv/wiki/Video4Linux2-Input)
	alias mirror='mpv --demuxer-lavf-o=video_size=1920x1080,input_format=mjpeg av://v4l2:/dev/video0 --profile=low-latency --untimed -vf=hflip --fs'

	# Shorten command for systemd user units
	alias sysu='systemctl --user'
fi

# Default to Kitty's hyperlinked ripgrep
alias rg=',hyperlinked-ripgrep'
