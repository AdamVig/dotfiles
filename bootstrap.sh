#!/bin/sh

# Symlink dotfiles into place
ln -sf .aliases ~
ln -sf .bash_profile ~
ln -sf .emacs.d ~
ln -sf .exports ~
ln -sf .git-template ~
ln -sf .zshrc ~

# Add custom Emacs config
ln -sf init-local.el ~/.emacs.d/lisp

# Run scripts
./brew.sh
./.osx

# Source dotfiles with installation steps
cd ~
. .zshrc
. .bash_profile

# Install npm tools
npm install -g bower
npm install -g grunt
npm install -g gulp
npm install -g jshint
npm install -g tldr
