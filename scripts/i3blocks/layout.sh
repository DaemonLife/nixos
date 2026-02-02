#!/bin/bash
echo $(setxkbmap -query | grep layout | awk '{print $2}')
