#!/bin/bash

# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail

DIR="$(dirname "$(realpath "$0")")"

# shellcheck source=./.functions
source "$DIR/.functions"

# Colorized output
# $1: color, template string, or string to print
# $2: template string or string to print
# all other arguments will be passed directly to printf
message() {
	# Get color from $1 if it matches the preset list of colors, if it does, shift the positional arguments
	COLOR=34
	OFF=0
	# More color codes: https://misc.flogisoft.com/bash/tip_colors_and_formatting
	case $1 in
		off)     COLOR=0; shift ;;
		red)     COLOR=31; shift ;;
		green)   COLOR=32; shift ;;
		yellow)  COLOR=33; shift ;;
		blue)    COLOR=34; shift ;;
		magenta) COLOR=35; shift ;;
		cyan)    COLOR=36; shift ;;
	esac

	# Get template from $1 if it is set, default to empty otherwise
	TEMPLATE=
	if [[ -n "$1" ]]; then
		TEMPLATE=${1:-}
		shift
	fi

	# If template string is not actually a template, add %s so that other arguments get printed
	if [[ $TEMPLATE != *"%s"* ]]; then
		TEMPLATE="$TEMPLATE%s"
	fi

	printf "\\e[${COLOR}m$TEMPLATE\\e[${OFF}m\\n" "$@"
}

# Log a warning
# all arguments will be passed to message, each will be printed on a new line with "warning:" preceding it
warn() {
	message "yellow" "warning: " "$@"
}

# Log an error
# all arguments will be passed to message, each will be printed on a new line with "error:" preceding it
error() {
	message "red" "error: " "$@"
}

# Log an error and exit with an error code
# all arguments will be passed to message, each will be printed on a new line with "error:" preceding it
fatal() {
	error "$@"
	exit 1
}

# Confirm if a user wants to do something
# Bypasses the prompt and proceeds if the variable SHOULD_CONFIRM is set to 0
# $1: message, defaults to 'Proceed?'
# returns 0 or 1 depending on user input, 0 means no, 1 means yes
confirm() {
	# Whether or not to skip prompt
	# Use value of SHOULD_CONFIRM; if not set, default to 1 (skip prompt)
	SHOULD_PROMPT=${SHOULD_CONFIRM:-1}
	if [[ "$SHOULD_PROMPT" = 1 ]]; then
			return 0 # automatic yes
	fi

	MESSAGE=${1:-"Proceed?"}
	read -p "$MESSAGE (y/n) " -n 1 -r
	message
	[[ $REPLY =~ ^[Yy]$ ]] # REPLY is automatically set to the result of `read`
	return $? # result of previous line, either 0 (yes) or 1 (no)
}

# Get the GitHub release URL matching a given pattern
# $1: repository URL in format: [owner]/[repo name]
# $2: pattern to match
get-release-url() {
    # Check if jq is available for JSON parsing
    if [[ -z "$(command -v jq)" ]]; then
        warn "could not get release url for $1 because jq is not installed"
        return 100
    fi

    # Get list of releases
    echo "$(
        curl -s "https://api.github.com/repos/$1/releases/latest" | \
        jq --raw-output ".assets[] | .browser_download_url | select(endswith(\"$2\"))"
    )"
}

# Prompt the user for their password with a custom message
# If any arguments are provided, they will be passed to sudo
# If no arguments are provided, update the user's cached credentials and extend the sudo timeout for five minutes
request-sudo() {
    SUDO_PROMPT="Enter the system password for user %p: "
    if [[ $# -eq 0 ]]; then
        sudo --validate --prompt "$SUDO_PROMPT"
    else
        sudo --prompt "$SUDO_PROMPT" "$@"
    fi
}

# On WSL, get the absolute WSL path to %APPDATA% for the current user on the host system
get-appdata-path() {
	# https://superuser.com/a/1391349/201849
	wslpath "$(cmd.exe /C 'echo | set /p _=%APPDATA%')"
}
