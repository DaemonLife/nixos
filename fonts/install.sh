#!/usr/bin/env bash
mkdir ~/.local/share/fonts/
cp * ~/.local/share/fonts/
fc-cache -fv

fc-list | grep Unifont
