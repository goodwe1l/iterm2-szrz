#!/bin/bash
export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"

osascript -e 'tell application "iTerm2" to version' > /dev/null 2>&1 && NAME=iTerm2 || NAME=iTerm


# LOG=/tmp/zmodem-recv.log
# echo "$(date): recv script triggered" >> "$LOG"

RZ_BIN=$(command -v rz 2>/dev/null)
# echo "$(date): NAME=$NAME RZ_BIN=$RZ_BIN" >> "$LOG"

if [[ $RZ_BIN = "" ]]; then
	echo rz not found in PATH. Please install lrzsz.
	exit 1
fi

if [[ $NAME = "iTerm" ]]; then
	FILE=$(osascript -e 'tell application "iTerm" to activate' -e 'tell application "iTerm" to set thefile to choose folder with prompt "Choose a folder to place received files in"' -e "do shell script (\"echo \"&(quoted form of POSIX path of thefile as Unicode text)&\"\")")
else
	FILE=$(osascript -e 'tell application "iTerm2" to activate' -e 'tell application "iTerm2" to set thefile to choose folder with prompt "Choose a folder to place received files in"' -e "do shell script (\"echo \"&(quoted form of POSIX path of thefile as Unicode text)&\"\")")
fi

if [[ $FILE = "" ]]; then
	echo Cancelled.
	# Send ZModem cancel
	echo -e \\x18\\x18\\x18\\x18\\x18
	sleep 1
	echo
	echo \# Cancelled transfer
else
	cd "$FILE"
	"$RZ_BIN" --rename --escape --binary --bufsize 4096 
	sleep 1
	echo
	echo
	echo \# Sent \-\> $FILE
fi
