#!/bin/bash
# Notification Bell SSH — Stop Hook
# Plays a sound on a remote machine via SSH when Claude Code finishes a task.
#
# Reads configuration from ~/.claude/.notification-bell-ssh.conf
# The sound plays in the background so it doesn't block Claude from exiting.

CONF_FILE="$HOME/.claude/.notification-bell-ssh.conf"

# Check if notifications are enabled
if [[ ! -f "$HOME/.claude/.notification-bell-enabled" ]]; then
  exit 0
fi

# Check config exists
if [[ ! -f "$CONF_FILE" ]]; then
  exit 0
fi

# Load config
source "$CONF_FILE"

# Validate required config
if [[ -z "$SSH_TARGET" ]] || [[ -z "$SOUND_COMMAND" ]]; then
  exit 0
fi

# Play sound on remote machine (backgrounded so hook doesn't block)
ssh "$SSH_TARGET" "$SOUND_COMMAND" &>/dev/null &

exit 0
