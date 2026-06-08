#!/bin/bash

if command -v makoctl &>/dev/null && makoctl mode 2>/dev/null | grep -q 'do-not-disturb'; then
  echo '{"text": "󰂛", "tooltip": "Notifications silenced", "class": "active"}'
elif command -v dunstctl &>/dev/null && dunstctl is-paused 2>/dev/null | grep -q "true"; then
  echo '{"text": "󰂛", "tooltip": "Notifications silenced", "class": "active"}'
elif command -v swaync-client &>/dev/null && swaync-client --get-dnd 2>/dev/null | grep -q "true"; then
  echo '{"text": "󰂛", "tooltip": "Notifications silenced", "class": "active"}'
else
  echo '{"text": ""}'
fi
