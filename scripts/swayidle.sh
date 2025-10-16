swayidle -w \
  timeout 600 'sudo brightnessctl -s; sudo brightnessctl set 0%' resume 'sudo brightnessctl -r' \
  timeout 610 'swaymsg "output * dpms off"' resume 'swaymsg "output * dpms on"' \
  timeout 615 'swaymsg input "type:keyboard xkb_switch_layout 0"; swaylock -f' resume 'swaymsg "output * dpms on"; sudo brightnessctl -r'

before-sleep 'swaylock -f'
