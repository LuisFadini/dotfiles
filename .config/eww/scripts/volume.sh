#!/usr/bin/env bash

get_sink_status() {
  sink_id=$1
  volume=$(pactl list sinks | grep -A 10 "Sink #$sink_id" | grep 'Volume:' | awk '{print $5}' | cut -d'%' -f1)
  mute_status=$(pactl list sinks | grep -A 15 "Sink #$sink_id" | grep 'Mute:' | awk '{print $2}')

  echo "{ \"volume\": $volume, \"muted\": $( [[ "$mute_status" == "yes" ]] && echo "true" || echo "false") }"
}

DEFAULT_SINK_NAME="$(pactl get-default-sink)"
DEFAULT_SINK_ID="$(pactl list sinks short | grep "$DEFAULT_SINK_NAME" | awk '{print $1}')"
CURR_STATUS="$(get_sink_status $DEFAULT_SINK_ID)"

echo $CURR_STATUS

pactl subscribe | while read -r line; do
  if echo "$line" | grep -q "Event 'change' on sink #$DEFAULT_SINK_ID"; then
    NEW_STATUS="$(get_sink_status $DEFAULT_SINK_ID)"

    if [[ "$CURR_STATUS" != "$NEW_STATUS" ]]; then
      CURR_STATUS=$NEW_STATUS
      echo $CURR_STATUS
    fi

    DEFAULT_SINK_NAME="$(pactl get-default-sink)"
    DEFAULT_SINK_ID="$(pactl list sinks short | grep "$DEFAULT_SINK_NAME" | awk '{print $1}')"
  fi
done