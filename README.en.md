# iTerm/iTerm2 ZModem Scripts

[中文](README.md) | [English](README.en.md)

Scripts for fast file upload/download via `rz/sz` (ZModem) in `iTerm`/`iTerm2`.

## Features

- `iterm2-send-zmodem.sh`: Select a local file and send it to the remote host (when remote runs `rz`).
- `iterm2-recv-zmodem.sh`: Select a local folder and receive files from remote (when remote runs `sz`).
- Automatically supports both `iTerm` and `iTerm2`.
- Automatically checks whether `rz/sz` is installed.

## Requirements

- macOS
- `iTerm` or `iTerm2`
- `lrzsz` (provides `rz`/`sz` commands)

Install `lrzsz`:

```bash
brew install lrzsz
```

## Installation

1. Put scripts in a fixed directory, for example:

```bash
mkdir -p ~/.iterm2-zmodem
cp iterm2-send-zmodem.sh ~/.iterm2-zmodem/
cp iterm2-recv-zmodem.sh ~/.iterm2-zmodem/
chmod +x ~/.iterm2-zmodem/iterm2-*.sh
```

2. Add iTerm2 Triggers:

Path: `iTerm2 -> Settings -> Profiles -> Advanced -> Triggers -> Edit`

Add two rules (Action: `Run Silent Coprocess`):

| Regular Expression | Parameters |
| --- | --- |
| `\*\*B0100` | `~/.iterm2-zmodem/iterm2-send-zmodem.sh` |
| `\*\*B00000000000000` | `~/.iterm2-zmodem/iterm2-recv-zmodem.sh` |

> If your script location is different, replace with your actual absolute path.

## Usage

### Upload (Local -> Remote)

1. Run on remote:

```bash
rz
```

2. A file picker will pop up locally. Choose the file to upload.

### Download (Remote -> Local)

1. Run on remote:

```bash
sz <filename>
```

For example:

```bash
sz app.log
```

2. A folder picker will pop up locally. Choose where to save files.

## Troubleshooting

- `rz not found` / `sz not found`:
  - Ensure `lrzsz` is installed.
  - The scripts include `PATH=/opt/homebrew/bin:/usr/local/bin:$PATH`, which usually covers both Apple Silicon and Intel Homebrew paths.

- Trigger does not work:
  - Make sure Trigger is added under the profile you are currently using.
  - Make sure scripts are executable: `chmod +x ~/.iterm2-zmodem/iterm2-*.sh`.
  - Try absolute paths instead of `~`.

## Notes

These scripts use AppleScript to open iTerm/iTerm2 file/folder pickers. If you cancel selection, a ZModem cancel signal is sent to avoid a stuck session.
