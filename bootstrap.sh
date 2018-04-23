#!/bin/bash

# Get script directory (allows running from outside `dotfiles` dir)
DIR="$( cd "$(dirname "$0")" || return; pwd -P )"

source "$DIR/helpers.sh"

# Ask for password at start
sudo -v

message "Symlinking dotfiles into your home directory..."
ln -sf "$DIR/.aliases" ~
ln -sf "$DIR/.bash_profile" ~
ln -sf "$DIR/.bashrc" ~
ln -sf "$DIR/.eslintrc.json" ~
ln -sf "$DIR/.exports" ~
ln -sf "$DIR/.functions" ~
ln -sf "$DIR/.git-template" ~
ln -sf "$DIR/.profile" ~
ln -sf "$DIR/.zprofile" ~
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
    "$DIR/macos.sh"
    "$DIR/brew.sh"
    "$DIR/vscode.sh"

# Run Linux install scripts
elif [[ $(uname) == 'Linux' ]]; then
    "$DIR/apt.sh"
    "$DIR/linux.sh"
fi

"$DIR/git.sh"
"$DIR/golang.sh"
"$DIR/node.sh"
"$DIR/pip.sh"

message "Done. Start a new login shell or run 'source .zshrc'."
