#!/usr/bin/env bash

# ---- mise (runtime version manager) ---- #
if command -v mise &>/dev/null; then
  eval "$(mise activate zsh)"
  mise completion bash --include-bash-completion-lib >"${XDG_DATA_HOME}/bash-completion/completions/mise"
  mise completion zsh >"${ZDOTDIR}/completions/_mise"
fi
