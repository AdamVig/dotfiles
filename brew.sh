#!/bin/sh

# TODO: Convert to loop, pipe warnings to /dev/null

# Refresh homebrew
brew update
brew upgrade

# Command line upgrades
brew install bash
brew install curl
brew install git
brew install wget
brew install zsh

# Utilities
brew install cheat
brew install emacs
brew install httpie
brew install ssh-copy-id
brew install z

# Languages
brew install node
brew install python3

# Applications
brew cask install flux
brew cask install google-chrome
brew cask install spotify
