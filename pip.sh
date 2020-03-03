#!/usr/bin/env bash

DIR="$(dirname "$(realpath "$0")")"

# shellcheck source=./helpers.sh
source "$DIR/helpers.sh"

message "installing pip tools..."
pip_packages=(
  csvkit # CSV processing tools
  gcalcli # Google Calendar CLI
  pip # Package manager
  grip # GitHub README instant preview
  visidata # Data set visualizer
)

for package in "${pip_packages[@]}"; do
  pip3 install --upgrade --user "$package" > /dev/null
  message "  %s" "installed $package"
done
message "pip done."
