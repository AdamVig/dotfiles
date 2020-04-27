#!/usr/bin/env bash

DIR="$(dirname "$(realpath "$0")")"

# shellcheck source=./helpers.sh
source "$DIR/helpers.sh"

message "setting up WSL..."

message "  %s" "copying WSL configuration..."
request-sudo cp "$DIR"/wsl.conf /etc/wsl.conf

message "  %s" "copying Windows Terminal configuration..."
readonly appdata_local_path="$(wslpath "$("$DIR"/bin/expand-windows-path %APPDATALOCAL%)")"
windows_terminal_path="$appdata_local_path"/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/
mkdir -p "$windows_terminal_path"
cp "$DIR"/windows-terminal-profiles.json "$windows_terminal_path"/profiles.json

message "done setting up WSL."
