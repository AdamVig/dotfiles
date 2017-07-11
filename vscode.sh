#!/bin/bash

# Colorized output
# $1: string to print, must be quoted
# $2: optional, name of color, defaults to yellow
function message() {
    YELLOW="\e[33m"
    DEFAULT="\e[0m"
    printf "$YELLOW%s$DEFAULT\n" "$1"
}

message "Setting up Visual Studio Code..."

message "  Symlinking Visual Studio Code settings... "
ln -sf "$PWD/.vscode/settings.json" ~/Library/Application\ Support/Code/User/settings.json
ln -sf "$PWD/keybindings.json" ~/Library/Application\ Support/Code/User/keybindings.json
ln -sf "$PWD/snippets/" ~/Library/Application\ Support/Code/User/snippets

declare -a extensions=(
    Compulim.vscode-clock   # Statusbar clock
    KnisterPeter.vscode-github  # GitHub integration
    eamodio.gitlens  # Advanced Git integration
    mrmlnc.vscode-scss  # SCSS IntelliSense and autocomplete
    msjsdiag.debugger-for-chrome  # Chrome debugger integration
    tootone.org-mode  # Emacs Org-Mode support
)

message "  Installing Visual Studio Code extensions... "
for extension in "${extensions[@]}"; do
    code --install-extension "$extension" &> /dev/null
    message "    Installed $extension"
done

message "Visual Studio Code done."