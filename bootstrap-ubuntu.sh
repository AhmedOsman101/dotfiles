#!/usr/bin/env bash

set +e # Disable exit on error

# Install nala
sudo apt install nala -y

# Install nala packages
while IFS= read -r line; do
  sudo nala install "$line" -y
done <"installed_packages.txt"

# Install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install homebrew packages
brew bundle

# Install pnpm
curl -fsSL https://get.pnpm.io/install.sh | sh -

# Install pnpm packages
while IFS= read -r line; do
  pnpm add -g "$line"
done <"pnpm_global_packages.txt"

# Insatll flatpak apps
while IFS= read -r line; do
  # Install nala packages
  flatpak install "$line" -y
done <"flatpak_apps.txt"
