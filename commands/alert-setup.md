---
description: "Configure the remote machine and sound for notification bell"
argument-hint: ""
---

# Notification Bell SSH — Setup Command

Guide the user through configuring their remote notification bell.

## Instructions

Ask the user for two pieces of information:

### 1. SSH Target

Ask: "What's the SSH target for the machine with your speakers? (e.g., `user@hostname` or `user@192.168.1.100`)"

This should be a machine they can already SSH to without a password prompt (SSH keys or agent forwarding must be set up).

### 2. Sound

Ask what operating system the remote machine runs, then help them pick a sound:

**Windows:**
Available sounds in `C:\Windows\Media\`:
- `Ring01.wav` through `Ring10.wav` — ringtones
- `Alarm01.wav` through `Alarm10.wav` — alarms
- `chimes.wav`, `chord.wav`, `ding.wav`, `tada.wav` — classic Windows sounds
- `Windows Notify Email.wav`, `Windows Notify Messaging.wav` — notifications

The command format for Windows is:
```
powershell -Command "(New-Object Media.SoundPlayer 'C:\\Windows\\Media\\SOUND_FILE').PlaySync()"
```

**macOS:**
```
afplay /System/Library/Sounds/Ping.aiff
```
Other macOS sounds: `Glass.aiff`, `Hero.aiff`, `Submarine.aiff`, `Tink.aiff`

**Linux:**
```
paplay /usr/share/sounds/freedesktop/stereo/complete.oga
```
Other Linux sounds: `bell.oga`, `alarm-clock-elapsed.oga`, `dialog-information.oga`

### 3. Test the sound

Before saving, test it:
```bash
ssh "USER@HOST" "SOUND_COMMAND"
```

Ask the user if they heard it. If not, troubleshoot (volume, correct sound path, SSH connectivity).

### 4. Save configuration

Once confirmed working, write the config file:

```bash
cat > ~/.claude/.notification-bell-ssh.conf << 'CONF'
# Notification Bell SSH Configuration
# SSH target — the machine with your speakers
SSH_TARGET="user@hostname"

# Command to play sound on the remote machine
SOUND_COMMAND="powershell -Command \"(New-Object Media.SoundPlayer 'C:\\Windows\\Media\\Ring01.wav').PlaySync()\""
CONF
chmod 600 ~/.claude/.notification-bell-ssh.conf
```

Replace the values with what the user provided.

### 5. Enable it

```bash
touch ~/.claude/.notification-bell-enabled
```

Tell the user: "All set! Notification bell is configured and enabled. Use `/alert off` to disable or `/alert on` to re-enable."

## Prerequisites Note

If SSH to the target fails, remind the user they need passwordless SSH set up:
```bash
ssh-copy-id user@hostname
```
