#!/bin/bash

# Symlink dotfiles into place
ln -sf "$PWD/.aliases" ~
ln -sf "$PWD/.bash_profile" ~
ln -sf "$PWD/.emacs.d" ~
ln -sf "$PWD/.exports" ~
ln -sf "$PWD/.git-template" ~
ln -sf "$PWD/.zshrc" ~

# Clone .emacs.d submodule
git submodule update --init --recursive

# Add custom Emacs config
ln -sf "$PWD/init-local.el" ~/.emacs.d/lisp

# Run OS X install scripts
if [[ $(uname) == 'Darwin' ]]; then
    ./.osx
    ./brew.sh

# Run Linux install scripts
elif [[ $(uname) == 'Linux' ]]; then
    ./apt.sh
fi

# Install Oh My Zsh and  Zsh Syntax Highlighting
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

# Source dotfiles with installation steps
cd ~
. .bash_profile
source .zshrc

# Install npm tools
npm install -g bower
npm install -g grunt
npm install -g gulp
npm install -g jshint
npm install -g tldr

# Install pip tools
pip install grip # GitHub README instant preview
