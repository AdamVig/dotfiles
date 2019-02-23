#!/usr/bin/env bash

# Get script directory (allows running from outside `dotfiles` dir)
DIR="$( cd "$(dirname "$0")" || return; pwd -P )"

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
