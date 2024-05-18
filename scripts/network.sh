#!/bin/sh

rx1=$(cat /sys/class/net/enp10s0f3u1u2/statistics/rx_bytes)
tx1=$(cat /sys/class/net/enp10s0f3u1u2/statistics/tx_bytes)
sleep .2
rx2=$(cat /sys/class/net/enp10s0f3u1u2/statistics/rx_bytes)
tx2=$(cat /sys/class/net/enp10s0f3u1u2/statistics/tx_bytes)
# remove the * 8 for Megabit instead of Megabyte
rx=$(echo "(($rx2 - $rx1)*5) / (125 * 8)" | bc)
tx=$(echo "(($tx2 - $tx1)*5) / (125 * 8)" | bc)

echo "U:${tx}kB D:${rx}kB"
