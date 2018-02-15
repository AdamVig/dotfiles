#!/bin/bash

source helpers.sh

message "Installing pip tools..."
pip_packages=(
    pip
    cheat    # Bash command cheatsheets
    grip    # GitHub README instant preview
    httpie    # Better curl
)

for package in "${pip_packages[@]}"; do
    pip3 install --upgrade --user "$package" &> /dev/null
    message "  Installed $package"    
done
message "Pip done."
