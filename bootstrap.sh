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

# Run Linux install scripts
elif [[ $(uname) == 'Linux' ]]; then
    ./apt.sh
fi

message "Installing Oh My Zsh and Zsh Syntax Highlighting..."
OH_MY_ZSH_URL=https://raw.githubusercontent.com
OH_MY_ZSH_URL+=/robbyrussell/oh-my-zsh/master/tools/install.sh
sh -c "$(curl -fsSL "$OH_MY_ZSH_URL")"

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
    grunt    # Task runner
    gulp    # Task runner
    jshint    # JavaScript linter
    tldr    # Simple Bash command docs; used by 'what' alias
)

for package in "${npm_packages[@]}"; do
    npm install -g "$package"
done

message "Installing pip tools..."
pip_packages=(
    pip
    cheat    # Bash command cheatsheets
    grip    # GitHub README instant preview
    httpie    # Better curl
)

for package in "${pip_packages[@]}"; do
    pip install --upgrade "$package"
done

message "Configuring git..."
# TODO check for ~/.gitconfig, if not exist, prompt for settings
git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"

message "Done. Start a new login shell or run 'source .zshrc'."
