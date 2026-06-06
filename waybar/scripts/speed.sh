#!/bin/bash

C_ACCENT="#c4a0f0"
C_MUTED="#8c92a3"
C_TEXT="#dcd6d6"
CACHE="/tmp/waybar_speed"

IFACE=$(ip route | grep default | awk '{print $5}' | head -n 1)
[ -z "$IFACE" ] && echo "<span color='${C_MUTED}'>↓-- · ↑--</span>" && exit 0

CUR=$(awk -v iface="$IFACE" '$1 ~ iface":" {print $2, $10}' /proc/net/dev 2>/dev/null)
[ -z "$CUR" ] && echo "<span color='${C_MUTED}'>↓-- · ↑--</span>" && exit 0

RX_CUR=$(echo "$CUR" | awk '{print $1}')
TX_CUR=$(echo "$CUR" | awk '{print $2}')

if [ -f "$CACHE" ]; then
  read -r RX_OLD TX_OLD TIME_OLD < "$CACHE"
  NOW=$(date +%s%N)
  DT=$(( (NOW - TIME_OLD) / 1000000 ))
  [ "$DT" -le 0 ] && DT=1
  RX_SPD=$(( (RX_CUR - RX_OLD) * 1000 / DT ))
  TX_SPD=$(( (TX_CUR - TX_OLD) * 1000 / DT ))
  [ "$RX_SPD" -lt 0 ] && RX_SPD=0
  [ "$TX_SPD" -lt 0 ] && TX_SPD=0

  fmt_short() {
    local val=$1
    if [ "$val" -ge 1048576 ]; then echo "$(awk "BEGIN {printf \"%.1f\", $val/1048576}")M"
    elif [ "$val" -ge 1024 ]; then echo "$(awk "BEGIN {printf \"%.0f\", $val/1024}")K"
    else echo "${val}B"; fi
  }

  RV=$(fmt_short "$RX_SPD")
  TV=$(fmt_short "$TX_SPD")
  echo "<span color='${C_ACCENT}'>↓</span><span color='${C_TEXT}'>${RV}</span> <span color='${C_MUTED}'>·</span> <span color='${C_ACCENT}'>↑</span><span color='${C_TEXT}'>${TV}</span>"
else
  echo "<span color='${C_MUTED}'>↓.. · ↑..</span>"
fi

echo "$RX_CUR $TX_CUR $(date +%s%N)" > "$CACHE"
