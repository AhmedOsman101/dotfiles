# ---- Auto-start tmux if not already running ---- #
if [[ -z "${TMUX}" ]]; then
  tmux attach 2>/dev/null || tmux
fi
