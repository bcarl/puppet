#!/bin/bash -e

SESSION=auto

if [ -t 0 ] && [ -z "$TMUX" ] && which tmux >/dev/null 2>&1; then
  if tmux has-session -t "$SESSION" >/dev/null 2>&1; then
    tmux -2 attach-session -t "$SESSION"
  else
    tmux -2 new-session -s "$SESSION"
  fi
fi
