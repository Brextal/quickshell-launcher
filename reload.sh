#!/bin/bash
kill $(pgrep -f "quickshell.*launcher/shell.qml") 2>/dev/null
sleep 0.2
qs -p /home/brextal/.config/quickshell/launcher/shell.qml &
disown
