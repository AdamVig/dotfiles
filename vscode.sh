#!/bin/bash

# Get script directory (allows running from outside `dotfiles` dir)
DIR="$( cd "$(dirname "$0")" || return; pwd -P )"

CYAN="36"

source "$DIR/helpers.sh"

message "Setting up Visual Studio Code..." "$CYAN"

message "  Symlinking Visual Studio Code settings... " "$CYAN"
ln -sf "$DIR/.vscode/settings.json" ~/Library/Application\ Support/Code/User/settings.json
ln -sf "$DIR/.vscode/keybindings.json" ~/Library/Application\ Support/Code/User/keybindings.json

declare -a extensions=(
    Angular.ng-template  # Angular template IntelliSense support
    Compulim.vscode-clock   # Statusbar clock
    dbaeumer.vscode-eslint  # JavaScript linter
    eamodio.gitlens  # Advanced Git integration
    EditorConfig.editorconfig  # Editor text style configuration
    eg2.vscode-npm-script  # package.json linting and npm script detection
    fabiospampinato.vscode-terminals  # terminal manager
    formulahendry.auto-close-tag  # close HTML tags automatically
    formulahendry.auto-rename-tag  # edit matching pairs of HTML tags at the same time
    James-Yu.latex-workshop  # all-in-one features and utilities for LaTeX typesetting
    KnisterPeter.vscode-github  # GitHub integration
    mrmlnc.vscode-scss  # SCSS IntelliSense and autocomplete
    ms-python.python  # Python support
    ms-vscode.Go  # Golang support
    ms-vsliveshare.vsliveshare  # Live code sharing
    msjsdiag.debugger-for-chrome  # Chrome debugger integration
    octref.vetur  # Vue.js support
    PeterJausovec.vscode-docker  # Docker support
    QassimFarid.ejs-language-support  # EJS (Embedded JS) template language support
    stkb.rewrap  # Reformats code comments and other text to a given line length
    streetsidesoftware.code-spell-checker  # Spell checker
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
