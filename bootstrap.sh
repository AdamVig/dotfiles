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

# Install Oh My Zsh and  Zsh Syntax Highlighting
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

# Source dotfiles with installation steps
cd ~
. .bash_profile

# Install npm tools
npm install -g bower
npm install -g grunt
npm install -g gulp
npm install -g jshint
npm install -g tldr

# Install pip tools
pip install grip # GitHub README instant preview
