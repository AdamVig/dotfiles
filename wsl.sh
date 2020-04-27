#!/usr/bin/env bash

DIR="$(dirname "$(realpath "$0")")"

# shellcheck source=./helpers.sh
source "$DIR/helpers.sh"

request-sudo

message "setting up WSL..."

message "  %s" "copying WSL configuration..."
request-sudo cp "$DIR"/wsl.conf /etc/wsl.conf

message "  %s" "copying Windows Terminal configuration..."
readonly appdata_local_path="$(wslpath "$("$DIR"/bin/expand-windows-path %LOCALAPPDATA%)")"
windows_terminal_path="$appdata_local_path"/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/
mkdir -p "$windows_terminal_path"
cp "$DIR"/windows-terminal-profiles.json "$windows_terminal_path"/profiles.json

message "  %s" "copying Emacs configuration..."
readonly appdata_roaming_path="$(wslpath "$("$DIR"/bin/expand-windows-path %APPDATA%)")"
cp "$DIR"/.emacs "$appdata_roaming_path"/.emacs

message "  %s" "installing WSL utilities..."
sudo apt-get install --yes ubuntu-wsl
message "  %s" "done installing WSL utilities."

message "done setting up WSL."
