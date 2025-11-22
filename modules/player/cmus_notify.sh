#!/usr/bin/env bash

get_album_art() {
    local dir_name=$(dirname "$1")
    local base_names="folder cover albumart front $2"

    # найти локальный файл обложки
    for name in $base_names; do
        file=$(find "$dir_name" -maxdepth 1 \
            -iregex ".*${name}.*\.\(jpg\|jpeg\|png\|webp\|gif\)" \
            -print -quit 2>/dev/null)
        [ -n "$file" ] && {
            img_file="$file"
            return
        }
    done

    # извлечь cover из файла через ffmpeg (надёжный способ)
    if command -v ffmpeg >/dev/null 2>&1; then
        dest="$HOME/.config/cmus/.cmus-cover.jpg"
        ffmpeg -loglevel error -y \
            -i "$1" \
            -an -vcodec mjpeg "$dest" 2>/dev/null && {
            img_file="$dest"
            return
        }
    fi

    # fallback — иконка
    img_file="audio-x-generic"
}

#############################################
# MAIN
#############################################

[ $# -eq 0 ] && exit 0

if [ "$2" = "playing" ]; then

    # собрать аргументы вида key value
    while [ $# -ge 2 ]; do
        eval "_$1=\"\$2\""
        shift 2
    done
    
    if [ -z "$_album" ]; then
        _album="No album"
    fi
    if [ -z "$_artist" ]; then
        _artist="No artist"
    fi
    if [ -z "$_title" ]; then
        _title="${_file##*/}"      # song.mp3
        _title="file: ${_title%.*}"      # song
    fi

    notification_sum="$_artist / $_album"
    notification_body="$_title"

    body_chars=$(printf "%s" "$notification_sum $notification_body" | wc -c)
    base_time=2000
    char_time=$(( (body_chars / 10) * 200 )) # +0.6 sec per 20 chars
    expire_time=$(( base_time + char_time ))

    # получить обложку
    get_album_art "$_file" "$_album"

    # файл для предотвращения дубликатов
    cache="$HOME/.config/cmus/.cmus_last_track"

    # если трек не изменился — не показывать уведомление
    if [ -f "$cache" ] && [ "$(cat "$cache")" = "$_file" ]; then
        exit 0
    fi

    # записать текущий трек в кэш
    echo "$_file" > "$cache"

    # показать уведомление
    notify-send --app-name "$notification_sum" --expire-time "$expire_time" --icon "$img_file" "$notification_body" 
fi
