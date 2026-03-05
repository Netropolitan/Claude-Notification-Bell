# Claude Notification Bell

A Claude Code plugin that plays a notification sound on a remote machine via SSH when Claude finishes a task.

## Why?

If you run Claude Code on a remote server (via SSH, VS Code Remote, etc.) but your speakers are on a different machine, the standard terminal bell won't reach you. This plugin bridges that gap by SSHing to the machine with your speakers and playing a sound directly.

## Install

Add this repo as a plugin marketplace, then install:

```bash
claude plugin marketplace add https://github.com/Netropolitan/Claude-Notification-Bell
claude plugin install notification-bell-ssh
```

## Setup

Run the setup command in Claude Code:

```
/alert-setup
```

This will guide you through:
1. Setting your SSH target (the machine with speakers)
2. Choosing a notification sound
3. Testing the sound
4. Saving the configuration

### Prerequisites

You need **passwordless SSH** to the machine with your speakers:

```bash
ssh-copy-id user@your-machine
```

## Usage

| Command | Description |
|---------|-------------|
| `/alert on` | Enable notification sound |
| `/alert off` | Disable notification sound |
| `/alert` | Check current status |
| `/alert-setup` | Configure remote machine and sound |

## How It Works

1. A **Stop hook** fires every time Claude Code finishes a task
2. The hook checks if notifications are enabled (`~/.claude/.notification-bell-enabled`)
3. If enabled, it reads the SSH target and sound command from `~/.claude/.notification-bell-ssh.conf`
4. It SSHs to your machine and plays the sound (backgrounded so it doesn't block Claude)

## Supported Platforms (Remote Machine)

| Platform | Example Sound Command |
|----------|----------------------|
| **Windows** | `powershell -Command "(New-Object Media.SoundPlayer 'C:\Windows\Media\Ring01.wav').PlaySync()"` |
| **macOS** | `afplay /System/Library/Sounds/Ping.aiff` |
| **Linux** | `paplay /usr/share/sounds/freedesktop/stereo/complete.oga` |

## Configuration

Config is stored at `~/.claude/.notification-bell-ssh.conf`:

```bash
# SSH target — the machine with your speakers
SSH_TARGET="user@hostname"

# Command to play sound on the remote machine
SOUND_COMMAND="paplay /usr/share/sounds/freedesktop/stereo/bell.oga"
```

## Manual Test

```bash
./scripts/test-sound.sh
```

## License

MIT

## License

MIT
