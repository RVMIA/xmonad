#!/bin/sh

if [ -n "$(pidof spotify)" ]; then

    artist=$(playerctl -p spotify metadata artist)
    song=$(playerctl metadata title -p spotify)
    artist="${artist:0:30}"
    song="${song:0:30}"

    position=$(playerctl -p spotify position | cut -f 1 -d '.')
    status=$(playerctl -p spotify status)
    length=$(playerctl -p spotify metadata mpris:length | sed 's/.\{6\}$//')
    percent=$((position * 100 / length))
    
    echo -n "$artist - $song - $percent% - $status"
fi
