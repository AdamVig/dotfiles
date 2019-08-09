#!/usr/bin/env bash

DIR="$(dirname "$(realpath "$0")")"

# shellcheck source=./helpers.sh
source "$DIR/helpers.sh"

message "Installing pip tools..."
pip_packages=(
    csvkit    # CSV processing tools
    pip
    grip    # GitHub README instant preview
    visidata   # Data set visualizer
)

for package in "${pip_packages[@]}"; do
    pip3 install --upgrade --user "$package" > /dev/null
    message "  %s" "Installed $package"
done
message "Pip done."
