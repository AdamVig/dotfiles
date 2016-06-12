#!/bin/bash

echo "Symlinking dotfiles into your home directory..."
ln -sf "$PWD/.aliases" ~
ln -sf "$PWD/.bash_profile" ~
ln -sf "$PWD/.bashrc" ~
ln -sf "$PWD/.emacs.d" ~
ln -sf "$PWD/.exports" ~
ln -sf "$PWD/.git-template" ~
ln -sf "$PWD/.zshrc" ~

echo "Cloning .emacs.d submodule..."
git submodule update --init --recursive

echo "Symlinking .emacs.d to your home directory..."
ln -sf "$PWD/init-local.el" ~/.emacs.d/lisp

echo "Running OS-specific scripts..."
if [[ $(uname) == 'Darwin' ]]; then
    ./.osx
    ./brew.sh

# Run Linux install scripts
elif [[ $(uname) == 'Linux' ]]; then
    ./apt.sh
fi

echo "Installing Oh My Zsh and Zsh Syntax Highlighting..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

echo "Loading .bash_profile and .zshrc..."
cd ~ || exit
. .bash_profile
source .zshrc

echo "Installing npm tools..."
npm install -g bower
npm install -g grunt
npm install -g gulp
npm install -g jshint
npm install -g tldr

echo "Updating pip..."
pip install --upgrade pip

echo "Installing pip tools..."
pip install cheat # Bash command cheatsheets
pip install grip # GitHub README instant preview
