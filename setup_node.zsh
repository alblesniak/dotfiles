#!/usr/bin/env zsh

echo "\n<<< Starting Node Setup >>>\n"

# Node versions are managed wit `n`, which is in the Brewfile.
# See zshrc for N_PREFIX variable and addition to PATH.

if exists node; then
    echo "Node $(node --version) and npm $(npm --version) already installed!"
else
    echo "Installing node and npm..."
    n latest
fi


# Install Global NPM Packages
npm install --global @angular/cli
npm install --global trash-cli
npm install --global pyright

echo "Global NPM Packages installed:"
npm list -global --depth=0
