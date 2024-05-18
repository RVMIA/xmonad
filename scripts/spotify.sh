#!/bin/sh
maxlen=50

running=$(pidof spotify)
if [ "$running" != "" ]; then

    artist=$(playerctl -p spotify metadata artist)
    song=$(playerctl metadata title -p spotify)

    artistlen=${#artist}
    songlen=${#song}
    
    maxartistlen=$maxlen
    maxsonglen=$maxlen
    
    if [ $artistlen -lt $maxlen ]
    then
	maxsonglen=$(echo "($maxlen * 2) - $artistlen" | bc)
    fi

    if [ $songlen -lt $maxlen ]
    then
	maxartistlen=$(echo "($maxlen * 2) - $songlen" | bc)
    fi

       
    if [ $artistlen -gt $maxartistlen ]
    then
	artist="$(echo "$artist" | cut -b 1-$maxartistlen)..."
    fi

  
    if [ $songlen -gt $maxsonglen ]
    then
	song="$(echo "$song" | cut -b 1-$maxsonglen)..."
    fi

    position=$(playerctl -p spotify position | cut -f 1 -d '.')
    status=$(playerctl -p spotify status)
    length=$(playerctl -p spotify metadata mpris:length | sed 's/.\{6\}$//')
    percent=$(echo "$position/$length" | bc -l | cut -b 2-3)
    
    echo -n "$artist - $song - $percent% - $status"
fi
