#!/bin/sh
used=$(free -h | grep M | cut -d " " -f 15-20 | xargs)
total=$(free -h | grep M | cut -d " " -f 5-14 | xargs)

echo "RAM:$used/$total"
