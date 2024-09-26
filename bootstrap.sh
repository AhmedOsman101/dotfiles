#!/usr/bin/env bash

# Install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Go to the .dotfiles directory and install your homebrew packages
cd ~/.dotfiles && brew bundle

# Go back to your previous working directory
cd - || exit

