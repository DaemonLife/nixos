DIRECTION="$1"

if [ -z "$DIRECTION" ]; then
  echo "Usage: $0 [next|prev]"
  exit 1
fi

# Получаем отсортированный список номеров всех существующих рабочих пространств.
# Вывод: [1, 2, 3, 5]
existing_nums=$(swaymsg -t get_workspaces | jq '[.[].num] | sort')

# Получаем номер текущего рабочего пространства
current_num=$(swaymsg -t get_workspaces | jq '.[] | select(.focused) | .num')

target_num=0

if [ "$DIRECTION" == "next" ]; then
  # Направление: Вперед (3 -> 4, или 5 -> 6)

  # Ищем первый пропущенный номер, начиная с текущего + 1
  for_check=$current_num
  while true; do
    for_check=$((for_check + 1))

    # Если номер не существует в массиве, это наш целевой номер
    if echo "$existing_nums" | jq "any(. == $for_check)" | grep -q "false"; then
      target_num=$for_check
      break
    fi

    # Защита от бесконечного цикла, если воркспейсы не числовые (но они должны быть)
    if [ "$for_check" -gt "$((current_num + 10))" ]; then break; fi
  done

elif [ "$DIRECTION" == "prev" ]; then
  # Направление: Назад (5 -> 4)

  # Ищем первый пропущенный номер, начиная с текущего - 1
  for_check=$current_num
  while [ "$for_check" -gt 1 ]; do
    for_check=$((for_check - 1))

    # Если номер не существует в массиве, это наш целевой номер
    if echo "$existing_nums" | jq "any(. == $for_check)" | grep -q "false"; then
      target_num=$for_check
      break
    fi
  done
fi

# --- Выполнение перехода ---
if [ "$target_num" -gt 0 ]; then
  # Если найден пропущенный номер, переходим непосредственно на него (создаем его)
  swaymsg workspace number "$target_num"
else
  # Если пропусков нет, используем стандартную команду Sway для перехода
  # на следующий/предыдущий существующий воркспейс.
  # Это также создает новый воркспейс, если мы находимся на последнем существующем
  # и используем 'next'.
  swaymsg workspace "$DIRECTION"
fi

exit 0
