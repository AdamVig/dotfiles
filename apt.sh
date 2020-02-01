#!/usr/bin/env bash

DIR="$(dirname "$(realpath "$0")")"

# shellcheck source=./helpers.sh
source "$DIR"/helpers.sh

message "Setting up apt..."

request-sudo apt-get update > /dev/null
request-sudo apt-get upgrade -y > /dev/null

message '  %s' 'Installing xdg-utils and wpasupplicant...'
sudo apt install -y xdg-utils wpasupplicant
message '  %s' 'Done installing xdg-utils and wpasupplicant.'

message "Done setting up apt."
