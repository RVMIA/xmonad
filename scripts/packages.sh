#!/bin/sh
num=$(equery list "*" | wc -l)

echo "$num pkgs"
