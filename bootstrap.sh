#!/bin/sh

# Copy dotfiles into place
cp .bash_profile ~
cp -r .emacs.d ~
cp .exports ~
cp .git-template ~
cp .zshrc ~

# Add custom Emacs config
cp init-local.el ~/.emacs.d/lisp

# Run scripts
./brew.sh
./.osx
. ~/.zshrc
. ~/.bash_profile

# Install npm tools
npm install -g bower
npm install -g grunt
npm install -g gulp
npm install -g jshint
npm install -g tldr
