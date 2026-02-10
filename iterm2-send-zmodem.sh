#!/bin/bash
export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"

osascript -e 'tell application "iTerm2" to version' > /dev/null 2>&1 && NAME=iTerm2 || NAME=iTerm


# LOG=/tmp/zmodem-send.log
# echo "$(date): send script triggered" >> "$LOG"
SZ_BIN=$(command -v sz 2>/dev/null)
# echo "$(date): NAME=$NAME SZ_BIN=$SZ_BIN" >> "$LOG"

if [[ $SZ_BIN = "" ]]; then
	echo sz not found in PATH. Please install lrzsz.
	exit 1
fi

if [[ $NAME = "iTerm" ]]; then
	FILE=$(osascript -e 'tell application "iTerm" to activate' -e 'tell application "iTerm" to set thefile to choose file with prompt "Choose a file to send"' -e "do shell script (\"echo \"&(quoted form of POSIX path of thefile as Unicode text)&\"\")")
else
	FILE=$(osascript -e 'tell application "iTerm2" to activate' -e 'tell application "iTerm2" to set thefile to choose file with prompt "Choose a file to send"' -e "do shell script (\"echo \"&(quoted form of POSIX path of thefile as Unicode text)&\"\")")
fi
if [[ $FILE = "" ]]; then
	echo Cancelled.
	# Send ZModem cancel
	echo -e \\x18\\x18\\x18\\x18\\x18
	sleep 1
	echo
	echo \# Cancelled transfer
else
	"$SZ_BIN" "$FILE" --escape --binary --bufsize 4096
	sleep 1
	echo
	echo \# Received "$FILE"
fi
