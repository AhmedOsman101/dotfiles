#!/usr/bin/env bash

# ---- zsh modules ---- #
zmodload zsh/datetime # EPOCHSECONDS for staleness checks (completion.sh, history.sh)

# ---- zsh options ---- #
unsetopt extendedglob
unsetopt nomatch

setopt AUTO_CD             # Type directory name to cd into it
setopt numericglobsort     # `echo file*` will output: file1 file2 file10 instead of: file1 file10 file2.
setopt interactivecomments # Allows # comments on the command line in interactive shells.
setopt nohistbeep          # Don't beep when a history entry isn't found.
setopt noflowcontrol       # Frees up ^S/^Q for other uses; they're a legacy terminal feature and often accidentally freeze your terminal.
setopt pipefail            # Pipeline exit status reflects the first non-zero command, not just the last.
setopt checkjobs           # Warns before exiting if you have background or stopped jobs.
