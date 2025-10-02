#!/usr/bin/env bash
DIRECTION="$1"

if [ -z "$DIRECTION" ]; then
  echo "Usage: $0 [next|prev]"
  exit 1
fi

# Номер текущего рабочего пространства
current_num=$(swaymsg -t get_workspaces | jq '.[] | select(.focused) | .num')

if [ "$DIRECTION" = "next" ]; then
  target_num=$((current_num + 1))
elif [ "$DIRECTION" = "prev" ]; then
  target_num=$((current_num - 1))
else
  echo "Usage: $0 [next|prev]"
  exit 1
fi

# --- Выполнение перехода ---
swaymsg workspace number "$target_num"
