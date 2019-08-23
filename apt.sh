#!/usr/bin/env bash

DIR="$(dirname "$(realpath "$0")")"

# shellcheck source=./helpers.sh
source "$DIR"/helpers.sh

message "Setting up apt..."

request-sudo apt-get update > /dev/null
request-sudo apt-get upgrade -y > /dev/null

message "Done setting up apt."
