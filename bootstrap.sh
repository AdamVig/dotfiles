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
DIR="$( cd "$(dirname "$0")" ; pwd -P )"

message "Symlinking dotfiles into your home directory..."
ln -sf "$DIR/.aliases" ~
ln -sf "$DIR/.bash_profile" ~
ln -sf "$DIR/.bashrc" ~
ln -sf "$DIR/.eslintrc.json" ~
ln -sf "$DIR/.exports" ~
ln -sf "$DIR/.git-template" ~
ln -sf "$DIR/.zshrc" ~

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

# Install custom Zsh theme
mkdir -p ~/.oh-my-zsh/custom/themes
ln -sf "$DIR/adamvig.zsh-theme" ~/.oh-my-zsh/custom/themes

message "Zsh done."

message "Running OS-specific scripts..."
if [[ $(uname) == 'Darwin' ]]; then
    "$DIR/.macos"
    "$DIR/brew.sh"
    "$DIR/vscode.sh"

# Run Linux install scripts
elif [[ $(uname) == 'Linux' ]]; then
    "$DIR/apt.sh"
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
    message "  Installed $package"    
done
message "npm done."

message "Installing pip tools..."
pip_packages=(
    pip
    cheat    # Bash command cheatsheets
    grip    # GitHub README instant preview
    httpie    # Better curl
)

for package in "${pip_packages[@]}"; do
    pip install --upgrade --user "$package" &> /dev/null
    message "  Installed $package"    
done
message "Pip done."

message "Installing golang tools..."
go_packages=(
    github.com/acroca/go-symbols  # Extract Go symbols as JSON
    github.com/cweill/gotests/...    # Generate tests
    github.com/fatih/gomodifytags  # Modify/update field tags in structs
    github.com/golang/lint/golint  # Go linter
    github.com/josharian/impl  # Generate method stubs for an interface
    github.com/nsf/gocode  # Autocomplete
    github.com/ramya-rao-a/go-outline  # Extract Go declarations as JSON
    github.com/rogpeppe/godef  # Print where symbols are defined
    github.com/sqs/goreturns  # Add zero values to return statements to save time
    github.com/tpng/gopkgs  # Faster `go list all`
    golang.org/x/tools/cmd/godoc  # Go documentation tool
    golang.org/x/tools/cmd/gorename  # Rename identifiers
    golang.org/x/tools/cmd/guru  # Answers questions about Go code
)

for package in "${go_packages[@]}"; do
    go get -u "$package" &> /dev/null
    message "  Installed $package"
done
message "Golang done."

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
