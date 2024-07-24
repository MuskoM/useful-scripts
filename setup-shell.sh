#!/bin/bash

# Check if zsh is installed
if ! zsh --version &> /dev/null; then
    echo "zsh not found. Installing zsh..."
    ./setup-prerequisites.sh -n -p zsh
fi

# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "Oh My Zsh installation complete!"
