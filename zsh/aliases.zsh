# Create command aliases.

# Run an npm script without excessive npm output
alias npr='npm run --silent'

alias glb="log-branch-commits"

# Display image in terminal
alias icat='kitty +kitten icat'

# Prevent wget from storing HSTS database in home directory
alias wget='wget --hsts-file="${XDG_CACHE_HOME:-$HOME/.cache}"/wget-hsts'

# Prevent units from storing history file in home directory
alias units='units --history="${XDG_CACHE_HOME:-$HOME/.cache}"/units_history'

alias e='emacsclient --create-frame --no-wait'
alias et='emacsclient --tty'

if command -v exa > /dev/null; then
  alias ls='exa'
fi

if [[ "$OSTYPE" = *linux* ]]; then
	# Show webcam feed locally (https://github.com/mpv-player/mpv/wiki/Video4Linux2-Input)
	alias mirror='mpv --demuxer-lavf-o=video_size=1920x1080,input_format=mjpeg av://v4l2:/dev/video0 --profile=low-latency --untimed -vf=hflip --fs'
fi
