#!/usr/bin/env bash
# AI code! Sorry...

# Skip empty/non-existent numeric workspaces in Sway — step next|prev
set -euo pipefail

dir="${1:-}"
if [[ "$dir" != "next" && "$dir" != "prev" ]]; then
  echo "Usage: $0 next|prev" >&2
  exit 1
fi

cur=$(swaymsg -t get_workspaces 2>/dev/null | jq -r '.[] | select(.focused==true) | .num' || true)
if [[ -z "$cur" || "$cur" == "null" ]]; then
  echo "Cannot determine current workspace" >&2
  exit 1
fi

step=1
[[ "$dir" == "prev" ]] && step=-1

max=200
target=$cur

for ((i=0;i<max;i++)); do
  target=$(( target + step ))
  # получить воркспейс с таким num (пусто, если нет)
  ws=$(swaymsg -t get_workspaces 2>/dev/null | jq --argjson n "$target" -c '.[] | select(.num == $n)' || true)
  if [[ -z "$ws" ]]; then
    # отсутствует — считаем пустым, продолжаем
    continue
  fi
  occupied=$(jq -r '((.nodes|length)+(.floating_nodes|length) > 0) or (.representation != "") or (.focus != null) or (.window != null)' <<<"$ws")
  if [[ "$occupied" == "true" ]]; then
    swaymsg workspace number "$target"
    exit 0
  fi
done

exit 0
