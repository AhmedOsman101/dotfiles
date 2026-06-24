#!/usr/bin/env bash

# ---  PHP-CS-Fixer --- #
if command -v php-cs-fixer &>/dev/null; then
  eval "$(php-cs-fixer completion zsh)"
fi
