#!/usr/bin/env bash

# For Hyprland WM

swayidle -w timeout 10 'hyprctl keyword input:kb_layout us,ru && swaylock -f' timeout 20 'hyprctl dispatch dpms off' resume 'hyprctl dispatch dpms on' before-sleep 'swaylock -f'

def
