#!/usr/bin/env bash

DIR="$(dirname "$(realpath "$0")")"

# shellcheck source=./helpers.sh
source "$DIR/helpers.sh"

message "Installing pip tools..."
pip_packages=(
    pip
    grip    # GitHub README instant preview
)

for package in "${pip_packages[@]}"; do
    pip3 install --upgrade --user "$package" > /dev/null
    message "  %s" "Installed $package"
done
message "Pip done."
