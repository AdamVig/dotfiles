#!/usr/bin/env bash

# Get script directory (allows running from outside `dotfiles` dir)
DIR="$( cd "$(dirname "$0")" || return; pwd -P )"

# shellcheck source=./helpers.sh
source "$DIR/helpers.sh"

message "cyan" "Setting up Visual Studio Code..."

message "cyan" "  %s" "Symlinking Visual Studio Code settings..."
if is-macos; then
    ln -sf "$DIR/.vscode/settings.json" ~/Library/Application\ Support/Code/User/settings.json
    ln -sf "$DIR/.vscode/keybindings.json" ~/Library/Application\ Support/Code/User/keybindings.json
fi

declare -a extensions=(
    Angular.ng-template  # Angular template IntelliSense support
    Compulim.vscode-clock   # Statusbar clock
    dbaeumer.vscode-eslint  # JavaScript linter
    eamodio.gitlens  # Advanced Git integration
    EditorConfig.editorconfig  # Editor text style configuration
    eg2.vscode-npm-script  # package.json linting and npm script detection
    emroussel.atomize-atom-one-dark-theme  # Atom-inspired theme
    fabiospampinato.vscode-terminals  # terminal manager
    GitHub.vscode-pull-request-github # built-in GitHub pull request support
    hbenl.vscode-test-explorer  # sidebar for running tests
    mrmlnc.vscode-scss  # SCSS IntelliSense and autocomplete
    ms-python.python  # Python support
    ms-vscode.Go  # Golang support
    ms-vsliveshare.vsliveshare  # Live code sharing
    msjsdiag.debugger-for-chrome  # Chrome debugger integration
    octref.vetur  # Vue.js support
    PeterJausovec.vscode-docker  # Docker support
    QassimFarid.ejs-language-support  # EJS (Embedded JS) template language support
    rafamel.subtle-brackets  # Better bracket matching
    stkb.rewrap  # Reformats code comments and other text to a given line length
    streetsidesoftware.code-spell-checker  # Spell checker
    timonwong.shellcheck  # Shell script linting
    yzhang.markdown-all-in-one  # Markdown keyboard shortcuts and formatting helpers
)

message "cyan" "  %s" "Installing Visual Studio Code extensions... "
for extension in "${extensions[@]}"; do
    set +e
    # Attempt to install extension; log message on success, log warning on failure
    code --install-extension "$extension" &> /dev/null && \
        message "cyan" "    %s" "Installed $extension" || \
        warn "extension $extension failed to install; it may no longer be available"
    set -e
done

message "cyan" "Visual Studio Code done."
