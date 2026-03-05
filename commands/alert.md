---
description: "Toggle notification sound when Claude finishes a task"
argument-hint: "[on|off]"
---

# Notification Bell SSH — Alert Command

Toggle an audible notification that plays on a remote machine via SSH when Claude finishes a task.

## Instructions

Parse the user's input to determine the action:

- `/alert on`: Enable notifications
- `/alert off`: Disable notifications
- `/alert` (no argument): Check current status

### Enable

```bash
touch ~/.claude/.notification-bell-enabled
```

Then confirm: "Notification bell enabled. You'll hear a sound when I finish a task."

### Disable

```bash
rm -f ~/.claude/.notification-bell-enabled
```

Then confirm: "Notification bell disabled."

### Check status

```bash
test -f ~/.claude/.notification-bell-enabled && echo "on" || echo "off"
```

Then report: "Notification bell is currently [on/off]."

### If not configured

Check if the config file exists:

```bash
test -f ~/.claude/.notification-bell-ssh.conf
```

If it doesn't exist, tell the user:

> Notification bell is not configured yet. Run `/alert-setup` to configure your remote machine and sound.
