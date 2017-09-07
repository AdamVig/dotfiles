#!/bin/bash

# Colorized output
# $1: string to print, must be quoted
# $2: optional, name of color, defaults to yellow
function message() {
    YELLOW="\e[33m"
    DEFAULT="\e[0m"
    printf "$YELLOW%s$DEFAULT\n" "$1"
}

# Get script directory (allows running from outside `dotfiles` dir)
DIR="$( cd "$(dirname "$0")" ; pwd -P )"

message "Setting up Visual Studio Code..."

message "  Symlinking Visual Studio Code settings... "
ln -sf "$DIR/.vscode/settings.json" ~/Library/Application\ Support/Code/User/settings.json
ln -sf "$DIR/keybindings.json" ~/Library/Application\ Support/Code/User/keybindings.json
ln -sf "$DIR/snippets/" ~/Library/Application\ Support/Code/User/snippets

declare -a extensions=(
    Angular.ng-template  # Angular template IntelliSense support
    christian-kohler.path-intellisense  # File path autocomplete
    Compulim.vscode-clock   # Statusbar clock
    KnisterPeter.vscode-github  # GitHub integration
    dbaeumer.vscode-eslint  # JavaScript linter
    donjayamanne.python  # Python support
    eamodio.gitlens  # Advanced Git integration
    EditorConfig.editorconfig  # Editor text style configuration
    eg2.tslint  # TypeScript linter
    eg2.vscode-npm-script  # package.json linting and npm script detection
    lukehoban.go  # Golang support
    mrmlnc.vscode-scss  # SCSS IntelliSense and autocomplete
    ms-vscode.csharp  # C# support
    msjsdiag.debugger-for-chrome  # Chrome debugger integration
    octref.vetur  # Vue.js support
    PeterJausovec.vscode-docker  # Docker support
    tootone.org-mode  # Emacs Org-Mode support
)

message "  Installing Visual Studio Code extensions... "
for extension in "${extensions[@]}"; do
    code --install-extension "$extension" &> /dev/null
    message "    Installed $extension"
done

message "Visual Studio Code done."