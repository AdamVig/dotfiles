#!/usr/bin/env bash

DIR="$(dirname "$(realpath "$0")")"

# shellcheck source=./helpers.sh
source "$DIR/helpers.sh"

# Check if directory is writable, if not, take ownership of it
message "  %s" "checking ownership of subdirectories of /usr/local..."
for dir in $(brew --prefix)/*; do
	if [ ! -w "$dir" ]; then
		request-sudo chown -R "$(whoami)" "$dir"
		message "    %s" "took ownership of $dir"
	fi
done
message "  %s" "done checking ownership of subdirectories of /usr/local."

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

# Disable dock bouncing
defaults write com.apple.dock no-bouncing -bool true

# Restart Dock and Finder
killall Dock
killall Finder
