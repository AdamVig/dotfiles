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

# Get script directory (allows running from outside `dotfiles` dir)
DIR="$(dirname "$(realpath "$0")")"

message "Symlinking dotfiles into your home directory..."
ln -sf "$DIR/.aliases" ~
ln -sf "$DIR/.bash_profile" ~
ln -sf "$DIR/.bashrc" ~
ln -sf "$DIR/.eslintrc.json" ~
ln -sf "$DIR/.exports" ~
ln -sf "$DIR/.git-template" ~
ln -sf "$DIR/.zshrc" ~

message "Running OS-specific scripts..."
if [[ $(uname) == 'Darwin' ]]; then
    "$DIR/.macos"
    "$DIR/brew.sh"
    "$DIR/vscode.sh"

# Run Linux install scripts
elif [[ $(uname) == 'Linux' ]]; then
    "$DIR/apt.sh"
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
# If gitconfig does not exist already, create one
if [ ! -e ~/.gitconfig ]; then
    message "  Copying gitconfig to home directory..."
    cp "$DIR/.gitconfig" ~
    
    message "  Configuring Git..."
    read -p "  Full name: " NAME
    read -p "  Email address: " EMAIL
    read -p "  Github username: " GITHUB

    # Only set values if they are non-empty
    [[ -n "$NAME" ]] && git config --global user.name "$NAME"
    [[ -n "$EMAIL" ]] && git config --global user.email "$EMAIL"
    [[ -n "$GITHUB" ]] && git config --global github.user "$GITHUB"
fi

message "Done. Start a new login shell or run 'source .zshrc'."
