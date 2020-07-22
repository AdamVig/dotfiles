#!/usr/bin/env bash

DIR="$(dirname "$(realpath "$0")")"

# shellcheck source=./helpers.sh
source "$DIR"/helpers.sh

message "setting up apt..."

request-sudo apt-get update >/dev/null
request-sudo apt-get upgrade -y >/dev/null

message '  %s' 'installing xdg-utils and wpasupplicant...'
sudo apt install -y xdg-utils wpasupplicant
message '  %s' 'done installing xdg-utils and wpasupplicant.'

message "done setting up apt."
