#!/usr/bin/env zsh

echo '\n<<< Starting Homebrew Setup >>>\n'

# Homebrew installation
if exists brew; then
    echo 'Homebrew already installed!'
else
    echo 'Installing homebrew...'
    yes | /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

fi

# Install from Brewfile
brew bundle --verbose

# Update and Upgrade
echo "Updating and upgrading Homebrew..."
yes | brew update
yes | brew upgrade

# Remove outdated versions from the cellar
echo "Cellar cleaning..."
brew cleanup
