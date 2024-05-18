#!/bin/sh
screenpath="/home/ame/Pictures/screenshots/$(date +%s)-screenshot.png"
maim -s $screenpath
sxiv $screenpath
thunar $screenpath/..
