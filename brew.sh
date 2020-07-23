#!/usr/bin/env bash

DIR="$(dirname "$(realpath "$0")")"

# shellcheck source=./helpers.sh
source "$DIR/helpers.sh"

# Refresh existing sudo session or start a new one
# shellcheck disable=SC2119
request-sudo

message "magenta" "  %s" "updating Brew package lists..."
brew update >/dev/null

message "magenta" "  %s" "installing Brew formulas..."
if ! brew bundle install --no-lock; then
	warn "installing Brew formulas may have failed"
fi

if "$DIR"/bin/is-macos && brew services list | grep --quiet --extended-regexp 'emacs .+ stopped'; then
	message "magenta" "  %s" "enabling Emacs service..."
	if brew services start emacs; then
		message "magenta" "  %s" "enabled Emacs service."
	else
		warn "failed to enable Emacs service."
	fi
fi

message "magenta" "brew done."
