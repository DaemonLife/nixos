# Переменная $1 должна содержать направление: "right" или "left"
DIRECTION="$1"

# Проверка и преобразование направления
case "$DIRECTION" in
"right")
  WORKSPACE_CMD="next"
  ;;
"left")
  WORKSPACE_CMD="prev"
  ;;
*)
  echo "Ошибка: Неверное направление. Используйте 'right' или 'left'." >&2
  exit 1
  ;;
esac

# --- Запрос jq вынесен и будет очищен ---
# Даже если вы скопировали его с лишними пробелами, tr их удалит.
JQ_FILTER_RAW='.. | select(.focused?) | .parent | select(.nodes) | {"current_index": (.nodes | map(.focused) | index(true)), "max_index": (.nodes | length) - 1}'

# Очистка запроса: удаляем все пробельные символы (пробелы, табы, переводы строк),
# оставляя только одну чистую строку фильтра.
JQ_FILTER=$(echo "$JQ_FILTER_RAW" | tr -d ' \t\n\r')

# 1. Получаем информацию об индексах
# Используем очищенный фильтр
INDEX_INFO=$(swaymsg -t get_tree | jq -r "$JQ_FILTER")

# 2. Проверяем на "null" или пустоту
if [ -z "$INDEX_INFO" ] || [[ "$INDEX_INFO" =~ "null" ]]; then
  swaymsg --quiet focus "$DIRECTION"
  exit 0
fi

# 3. Извлекаем текущий индекс и максимальный индекс
# Используем `echo` для передачи чистого JSON из INDEX_INFO
CURRENT_INDEX=$(echo "$INDEX_INFO" | jq -r '.current_index')
MAX_INDEX=$(echo "$INDEX_INFO" | jq -r '.max_index')

# 4. Проверяем, находимся ли мы на краю контейнера
IS_AT_EDGE=false

# Сравнения должны быть целочисленными (-eq)
if [ "$DIRECTION" == "right" ] && [ "$CURRENT_INDEX" -eq "$MAX_INDEX" ]; then
  IS_AT_EDGE=true
elif [ "$DIRECTION" == "left" ] && [ "$CURRENT_INDEX" -eq "0" ]; then
  IS_AT_EDGE=true
fi

# 5. Принимаем решение
if $IS_AT_EDGE; then
  swaymsg workspace "$WORKSPACE_CMD"
else
  swaymsg --quiet focus "$DIRECTION"
fi
