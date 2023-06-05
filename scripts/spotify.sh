running=$(pidof spotify)
if [ "$running" != "" ]; then
	artist=$(playerctl metadata artist -p spotify)
	song=$(playerctl metadata title -p spotify)
	position=$(playerctl -p spotify position | cut -f 1 -d '.')
	status=$(playerctl -p spotify status)
	artist=$(playerctl -p spotify metadata artist)
	album=$(playerctl -p spotify metadata album)
	length=$(playerctl -p spotify metadata mpris:length | sed 's/.\{6\}$//')
	percent=$(echo "$position/$length" | bc -l | cut -b 2-3)
	
	echo -n " $artist · $song - $percent% - $status "
fi
