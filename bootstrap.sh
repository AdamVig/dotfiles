#!/bin/bash

# Colorized output
# $1: string to print, must be quoted
# $2: optional, name of color, defaults to blue
function message() {
    BLUE="\e[34m"
    DEFAULT="\e[0m"
    printf "$BLUE%s$DEFAULT\n" "$1"
}

# Ask for password at start
sudo -v

message "Symlinking dotfiles into your home directory..."
ln -sf "$PWD/.aliases" ~
ln -sf "$PWD/.bash_profile" ~
ln -sf "$PWD/.bashrc" ~
ln -sf "$PWD/.emacs.d" ~
ln -sf "$PWD/.eslintrc.json" ~
ln -sf "$PWD/.exports" ~
ln -sf "$PWD/.git-template" ~
ln -sf "$PWD/.zshrc" ~

message "Cloning .emacs.d submodule..."
git submodule update --init --recursive

message "Symlinking .emacs.d to your home directory..."
ln -sf "$PWD/init-local.el" ~/.emacs.d/lisp

message "Running OS-specific scripts..."
if [[ $(uname) == 'Darwin' ]]; then
    ./.macos
    ./brew.sh

    message "Symlinking Visual Studio Code settings..."
    ln -sf "$PWD/.vscode/settings.json" ~/Library/Application\ Support/Code/User/settings.json
    ln -sf "$PWD/keybindings.json" ~/Library/Application\ Support/Code/User/keybindings.json
    ln -sf "$PWD/snippets/" ~/Library/Application\ Support/Code/User/snippets

# Run Linux install scripts
elif [[ $(uname) == 'Linux' ]]; then
    ./apt.sh
fi

message "Installing Oh My Zsh and Zsh Syntax Highlighting..."
OH_MY_ZSH_URL=https://raw.githubusercontent.com
OH_MY_ZSH_URL+=/robbyrussell/oh-my-zsh/master/tools/install.sh
sh -c "$(curl -fsSL "$OH_MY_ZSH_URL")" &> /dev/null

# Install Zsh Syntax highlighting if not already installed
ZSH_SYNTAX_FOLDER=~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
if [ ! -d "$ZSH_SYNTAX_FOLDER" ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
        "$ZSH_SYNTAX_FOLDER"
fi

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
done

message "Installing pip tools..."
pip_packages=(
    pip
    cheat    # Bash command cheatsheets
    grip    # GitHub README instant preview
    httpie    # Better curl
)

for package in "${pip_packages[@]}"; do
    pip install --upgrade --user "$package" &> /dev/null
done

message "Configuring git..."
# TODO check for ~/.gitconfig, if not exist, prompt for settings
git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"

# Set app icons if on macOS
if [[ $(uname) == 'Darwin' ]]; then
    message "Setting custom app icons..."
    fileicon set "/Applications/Emacs.app" "./assets/FlatEmacs.icns"
fi

message "Done. Start a new login shell or run 'source .zshrc'."
