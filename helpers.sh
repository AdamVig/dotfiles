#!/bin/bash

# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\n\t'

# Colorized output
# $1: string to print
# $2: (optional) color or other formatting number, see https://misc.flogisoft.com/bash/tip_colors_and_formatting
message() {
    BLUE="34"
    DEFAULT="0"

    OUTPUT=${1:-}

    # Use color from $2 if provided, otherwise use blue
    COLOR=${2:-$BLUE}

    printf "\\e[${COLOR}m%s\\e[${DEFAULT}m\\n" "$OUTPUT"
}

# Log a message and exit with an error code
# $1: string to print
fatal() {
    OUTPUT=${1:-}
    RED="31"
    message "error: $OUTPUT" "$RED"
    exit 1
}

# Log a warning
# $1: string to print
warn() {
    OUTPUT=${1:-}
    YELLOW="33"
    message "warning: $OUTPUT" "$YELLOW"
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
