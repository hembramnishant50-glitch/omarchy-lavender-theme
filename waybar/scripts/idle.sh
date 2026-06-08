#!/bin/bash

IDLE_RUNNING=false
for idled in hypridle swayidle xidle; do
  if pgrep -x "$idled" >/dev/null; then
    IDLE_RUNNING=true
    break
  fi
done

if $IDLE_RUNNING; then
  echo '{"text": ""}'
else
  echo '{"text": "󱫖", "tooltip": "Idle lock disabled", "class": "active"}'
fi
