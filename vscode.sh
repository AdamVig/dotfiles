#!/bin/bash

CYAN="36"

source helpers.sh

# Get script directory (allows running from outside `dotfiles` dir)
DIR="$( cd "$(dirname "$0")" ; pwd -P )"

message "Setting up Visual Studio Code..." "$CYAN"

message "  Symlinking Visual Studio Code settings... " "$CYAN"
ln -sf "$DIR/.vscode/settings.json" ~/Library/Application\ Support/Code/User/settings.json
ln -sf "$DIR/.vscode/keybindings.json" ~/Library/Application\ Support/Code/User/keybindings.json

declare -a extensions=(
    Angular.ng-template  # Angular template IntelliSense support
    christian-kohler.path-intellisense  # File path autocomplete
    Compulim.vscode-clock   # Statusbar clock
    dbaeumer.vscode-eslint  # JavaScript linter
    ms-python.python  # Python support
    eamodio.gitlens  # Advanced Git integration
    EditorConfig.editorconfig  # Editor text style configuration
    eg2.vscode-npm-script  # package.json linting and npm script detection
    formulahendry.auto-close-tag  # close HTML tags automatically
    formulahendry.auto-rename-tag  # edit matching pairs of HTML tags at the same time
    KnisterPeter.vscode-github  # GitHub integration
    lukehoban.go  # Golang support
    mrmlnc.vscode-scss  # SCSS IntelliSense and autocomplete
    msjsdiag.debugger-for-chrome  # Chrome debugger integration
    octref.vetur  # Vue.js support
    PeterJausovec.vscode-docker  # Docker support
    timonwong.shellcheck  # Shell script linting
    tootone.org-mode  # Emacs Org-Mode support
    yzhang.markdown-all-in-one  # Markdown keyboard shortcuts and formatting helpers
    zhuangtongfa.material-theme  # Atom One theme
)

message "  Installing Visual Studio Code extensions... " "$CYAN"
for extension in "${extensions[@]}"; do
    set +e
    # Attempt to install extension; log message on success, log warning on failure
    code --install-extension "$extension" &> /dev/null && \
        message "    Installed $extension" "$CYAN" || \
        warn "extension $extension failed to install; it may no longer be available"
    set -e
done

message "Visual Studio Code done." "$CYAN"
