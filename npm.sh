#!/bin/bash

source helpers.sh

message "Installing npm tools..."
npm_packages=(
    bower    # Frontend package manager
    diff-so-fancy    # Git diff prettifier
    emoj    # Emoji search engine
    eslint    # JavaScript style linter
    eslint-config-defaults    # Baseline ESLint settings
    fileicon    # Manage custom macOS file icons
    grunt    # Task runner
    gulp    # Task runner
    jshint    # JavaScript linter
    tldr    # Simple Bash command docs; used by 'what' alias
)

for package in "${npm_packages[@]}"; do
    npm install -g "$package" &> /dev/null
    message "  Installed $package"    
done
message "npm done."
