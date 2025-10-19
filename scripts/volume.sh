#!/usr/bin/env bash

# Устанавливаем значение увеличения громкости по умолчанию
increase=${1:-5}

# Увеличиваем громкость
pactl set-sink-volume @DEFAULT_SINK@ +"${increase}%"

# Получаем текущее значение громкости и убираем знак процента
current_volume=$(pactl get-sink-volume @DEFAULT_SINK@ | awk -F'/' '{print $2}' | tr -d ' %')

# Проверяем, если громкость больше 100, устанавливаем 100
if [ "$current_volume" -gt 100 ]; then
  pactl set-sink-volume @DEFAULT_SINK@ 100%
fi
