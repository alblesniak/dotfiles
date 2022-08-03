#!/usr/bin/env zsh

echo '\n<<< Starting Homebrew Setup >>>\n'

# Homebrew installation
bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install from Brewfile
brew bundle --verbose
