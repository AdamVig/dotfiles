#!/bin/bash

# Use this script when you change the settings for Terminal.app and want to update `apple-terminal-settings.plist` to
# contain the latest settings. The settings file cannot be symlinked into place because Terminal.app overwrites its
# settings every time the app is closed.

# Get script directory (allows running from outside `dotfiles` dir)
DIR="$( cd "$(dirname "$0")" || return; pwd -P )"

source "$DIR/../helpers.sh"

if [[ $(uname) == 'Darwin' ]]; then
    message "Exporting Terminal.app settings..."
    cp ~/Library/Preferences/com.apple.Terminal.plist "$DIR/../apple-terminal-settings.plist"
    message "Done exporting Terminal.app settings."
else
    warn "can only export Terminal.app settings on macOS"
fi