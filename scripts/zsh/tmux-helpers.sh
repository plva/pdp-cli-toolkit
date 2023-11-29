#!/bin/zsh

# FUNCTION_DOCUMENTATION_START
# - creates a base tmux session if none exists yet
# - fixes bug where CMD+{1,2,3...} doesn't switch windows if tmuxinator starts tmux sessions
# FUNCTION_DOCUMENTATION_END
tmux_or_start() {
  local session_name="$1"

  # Check if the session exists
  if ! tmux has-session -t "$session_name" 2>/dev/null; then
    # Session doesn't exist, start a new one
    tmux new-session -d -s "$session_name"
#    tmux detach-session -t "$session_name"
  else
    # Session already exists, attach to it
#    tmux attach-session -t "$session_name"
  fi
}

tmux_or_start "base"
