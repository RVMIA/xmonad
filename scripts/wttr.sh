#!/bin/sh
echo $(curl -s wttr.in/Richardson?format="%l:+%C+%t\n") | cut -d ' ' -f 2-
