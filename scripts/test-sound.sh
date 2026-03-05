#!/bin/bash
# Test the notification bell configuration
# Usage: ./test-sound.sh

CONF_FILE="$HOME/.claude/.notification-bell-ssh.conf"

if [[ ! -f "$CONF_FILE" ]]; then
  echo "Error: No configuration found at $CONF_FILE"
  echo "Run /alert-setup in Claude Code to configure."
  exit 1
fi

source "$CONF_FILE"

if [[ -z "$SSH_TARGET" ]] || [[ -z "$SOUND_COMMAND" ]]; then
  echo "Error: Configuration incomplete. SSH_TARGET and SOUND_COMMAND must be set."
  exit 1
fi

echo "Playing notification sound on $SSH_TARGET..."
ssh "$SSH_TARGET" "$SOUND_COMMAND"

if [[ $? -eq 0 ]]; then
  echo "Sound played successfully. Did you hear it?"
else
  echo "Error: Failed to play sound. Check your SSH connection and sound command."
  exit 1
fi
