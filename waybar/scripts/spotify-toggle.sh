#!/bin/bash

STATUS=$(playerctl -p spotify status 2>/dev/null)
if [ "$STATUS" = "Playing" ]; then
  playerctl -p spotify pause
elif [ "$STATUS" = "Paused" ]; then
  playerctl -p spotify play
else
  spotify &
fi
