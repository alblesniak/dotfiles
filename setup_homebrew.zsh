#!/usr/bin/env zsh

echo '\n<<< Starting Homebrew Setup >>>\n'

# Homebrew installation
if exists brew; then
    echo 'Homebrew already installed!'
else
    echo 'Installing homebrew...'
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

fi



# Install from Brewfile
brew bundle --verbose
