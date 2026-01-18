#!/usr/bin/env bash

get_brightness() {
  current=$(brightnessctl get)
  max=$(brightnessctl max)
  percent=$(( current * 100 / max ))

  echo "{ \"brightness\": $percent }"
}

CURR_STATUS="$(get_brightness)"
echo "$CURR_STATUS"

udevadm monitor --subsystem-match=backlight | while read -r _; do
  NEW_STATUS="$(get_brightness)"

  if [[ "$CURR_STATUS" != "$NEW_STATUS" ]]; then
    CURR_STATUS="$NEW_STATUS"
    echo "$CURR_STATUS"
  fi
done
