#!/usr/bin/env bash

# Get script directory (allows running from outside `dotfiles` dir)
DIR="$( cd "$(dirname "$0")" || return; pwd -P )"

# shellcheck source=./helpers.sh
source "$DIR/helpers.sh"

if ! command -v brew &> /dev/null; then
     message "  %s" "Installing Homebrew..."
     /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
     message "  %s" "Done installing Homebrew."
fi

# Check if directory is writable, if not, take ownership of it
message "  %s" "Checking ownership of subdirectories of /usr/local..."
for dir in $(brew --prefix)/*; do
    if [ ! -w "$dir" ]; then
        request-sudo chown -R "$(whoami)" "$dir"
        message "    %s" "Took ownership of $dir"
    fi
done
message "  %s" "Done checking ownership of subdirectories of /usr/local."

# Copy terminal settings (symlinking does not work because Terminal.app overwrites the file on close)
cp "$DIR/apple-terminal-settings.plist" ~/Library/Preferences/com.apple.Terminal.plist

# Disable startup tone
request-sudo nvram SystemAudioVolume=" "

# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Speed up Mission Control animations
defaults write com.apple.dock expose-animation-duration -float 0.1

# Disable Dashboard
defaults write com.apple.dashboard mcx-disabled -boolean YES

# Remove the auto-hiding Dock delay
defaults write com.apple.dock autohide-delay -float 0

# Remove the animation when hiding/showing the Dock
defaults write com.apple.dock autohide-time-modifier -float 0

# Disable automatic emoji substitution (i.e. use plain text smileys)
defaults write com.apple.messageshelper.MessageController SOInputLineSettings \
         -dict-add "automaticEmojiSubstitutionEnablediMessage" -bool false

# Disable automatic opening of Photos when device plugged in
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true

# Hide Finder tags
defaults write com.apple.finder ShowRecentTags -bool false

# Don’t automatically rearrange Spaces based on most recent use
defaults write com.apple.dock mru-spaces -bool false

# Hide username in menu bar
request-sudo defaults write /Library/Preferences/.GlobalPreferences \
     MultipleSessionEnabled -bool NO

# Reduce alert volume to 75%
osascript -e 'set volume alert volume 75'

# Enable tap to click
defaults -currentHost write -globalDomain com.apple.mouse.tapBehavior -int 0

# Disable natural scrolling
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

# Restart Dock and Finder
killall Dock
killall Finder
