running=$(pidof spotify)
if [ "$running" != "" ]; then
	artist=$(playerctl metadata artist -p spotify)
	song=$(playerctl metadata title -p spotify | cut -c 1-60)
	echo -n "$artist · $song"
fi
