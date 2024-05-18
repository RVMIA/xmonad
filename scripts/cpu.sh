#!/bin/sh
#echo "CPU: $(ps -A -o pcpu | tail -n+2 | paste -sd+ | bc)%"

topcall=$(top -b -n 1 |grep Cpu |tail -n 1)

user=$(echo $topcall |awk '{print $2}')
sys=$(echo $topcall |awk '{print $4}')
idle=$(echo $topcall |awk '{print $6}')

echo "$user  $sys  $idle" | awk '{ printf ("%.*f%\n", 1, $1 + $2 + $3); }'
