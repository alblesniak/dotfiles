#!/usr/bin/env zsh

echo "\n<<< Starting macOS Setup >>>\n"

### DOCK ###

# Set position of Dock to the left
defaults write com.apple.dock "orientation" -string "left"

# Set the icon size of Dock items to 35 pixels
defaults write com.apple.Dock "tilesize" -int 35

# Set the dock to autohide
defaults write com.apple.Dock "autohide" -bool "true" 

# Set the dock autohide delay to 0
defaults write com.apple.Dock "autohide-delay" -float 0

# Set the dock autohide animation to 0
defaults write com.apple.Dock "autohide-time-modifier" -float 0

# Sety to not show recently used apps
defaults write com.apple.dock "show-recents" -bool "false"

dockutil --no-restart --remove all
dockutil --no-restart --add "/Applications/Brave Browser.app"
dockutil --no-restart --add "/Applications/Kalendarz.app"
dockutil --no-restart --add "/Applications/Alacritty.app"
dockutil --no-restart --add "/Applications/Discord.app"
dockutil --no-restart --add "/Applications/WhatsApp.app"
dockutil --no-restart --add "/Applications/Zotero.app"

killall Dock
echo "Dock is set."

### FINDER ###

# Show the pathbar in the bottom of the Finder Windows
defaults write com.apple.finder "ShowPathbar" -bool "true"

# Set the default view style for folders without custom setting
defaults write com.apple.finder "FXPreferredViewStyle" -string "Nlsv"

# Keep folders on top when sorting by name
defaults write com.apple.finder "_FXSortFoldersFirst" -bool "true"

# Do not display the warning when changing a file extension in Finder
defaults write com.apple.finder "FXEnableExtensionChangeWarning" -bool "false"

# Keep folders on top when sorting
defaults write com.apple.finder "_FXSortFoldersFirstOnDesktop" -bool "true"

killall Finder
echo "Finder is set."


