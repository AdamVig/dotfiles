#!/bin/zsh

# Use Zsh colors function to enable friendly color names
autoload -U colors && colors

# Colorized output
# $1: string to print, must be quoted
# $2: optional, name of color, defaults to blue
function message() {
    COLOR=${2:=blue}
    printf "%s\n" "$fg[$COLOR]$1$fg[default]"
}

# Ask for password at start
sudo -v

message "Symlinking dotfiles into your home directory..."
ln -sf "$PWD/.aliases" ~
ln -sf "$PWD/.bash_profile" ~
ln -sf "$PWD/.bashrc" ~
ln -sf "$PWD/.emacs.d" ~
ln -sf "$PWD/.exports" ~
ln -sf "$PWD/.git-template" ~
ln -sf "$PWD/.zshrc" ~

message "Cloning .emacs.d submodule..."
git submodule update --init --recursive

message "Symlinking .emacs.d to your home directory..."
ln -sf "$PWD/init-local.el" ~/.emacs.d/lisp

message "Running OS-specific scripts..."
if [[ $(uname) == 'Darwin' ]]; then
    ./.osx
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

message "Loading .bash_profile and .zshrc..."
source ~/.zshrc

message "Installing npm tools..."
npm install -g bower    # Frontend package manager
npm install -g emoj    # Emoji search engine
npm install -g eslint    # JavaScript style linter
npm install -g grunt    # Task runner
npm install -g gulp    # Task runner
npm install -g jshint    # JavaScript linter
npm install -g tldr    # Simple Bash command docs; used by 'what' alias

message "Updating pip..."
pip install --upgrade pip

message "Installing pip tools..."
pip install --user cheat    # Bash command cheatsheets
pip install --user grip    # GitHub README instant preview
