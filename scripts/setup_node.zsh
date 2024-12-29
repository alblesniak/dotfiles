#!/bin/zsh

echo "\n<<< Starting Node Setup >>>\n"

# Node versions are managed with `n`, which is in the Brewfile.
# See zshrc for N_PREFIX variable and addition to PATH.

if command -v node >/dev/null 2>&1; then
    echo "Node $(node --version) and npm $(npm --version) already installed!"
else
    echo "Installing node and npm..."
    n latest || { echo "Failed to install Node.js"; exit 1; }
fi

# Install Global NPM Packages
GLOBAL_PACKAGES=("trash-cli")

for package in $GLOBAL_PACKAGES; do
    echo "Installing $package globally..."
    npm install --global $package || { echo "Failed to install $package"; exit 1; }
done

echo "Global NPM Packages installed:"
npm list --global --depth=0 || { echo "Failed to list global packages"; exit 1; }
