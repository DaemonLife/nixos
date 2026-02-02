#!/usr/bin/env bash

current=$(setxkbmap -query | grep layout | awk '{print $2}')

if [[ $current != "us" ]]; then
    new="us"
else
    new="ru"
fi

setxkbmap -layout $new

