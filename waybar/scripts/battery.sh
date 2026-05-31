#!/bin/bash

C_ACCENT="#c4a0f0"
C_MUTED="#8c92a3"
C_TEXT="#dcd6d6"

BAT=$(upower -e | grep -i bat | head -1)
[ -z "$BAT" ] && echo "" && exit 0

DATA=$(upower -i "$BAT" 2>/dev/null)
CAP=$(echo "$DATA" | grep -i percentage | grep -oP '\d+(?=%)')
STAT=$(echo "$DATA" | grep -i state | awk '{print $2}')
MODEL=$(echo "$DATA" | grep -i model | awk -F: '{print $2}' | xargs)
T2E=$(echo "$DATA" | grep -i 'time to empty' | grep -oP '[\d.]+ (hours|minutes|hour|minute)' | head -1)
T2F=$(echo "$DATA" | grep -i 'time to full' | grep -oP '[\d.]+ (hours|minutes|hour|minute)' | head -1)
WATTS=$(echo "$DATA" | grep -i 'energy-rate' | awk '{print $2}' | head -1)
VOLTS=$(echo "$DATA" | grep -i 'voltage' | awk '{print $2}' | head -1)
ENERGY=$(echo "$DATA" | grep -i 'energy:' | awk '{print $2}' | head -1)
E_FULL=$(echo "$DATA" | grep -i 'energy-full:' | awk '{print $2}' | head -1)
E_DESIGN=$(echo "$DATA" | grep -i 'energy-full-design' | awk '{print $2}' | head -1)
TEMP=$(echo "$DATA" | grep -i 'temperature' | awk '{print $2}' | head -1)

[ -z "$CAP" ] && CAP=0
[ -n "$E_FULL" ] && [ -n "$E_DESIGN" ] && [ "$E_DESIGN" != "0" ] && HEALTH=$(echo "scale=1; $E_FULL / $E_DESIGN * 100" | bc -l 2>/dev/null | sed 's/\.0$//') || HEALTH=""

case "$STAT" in
  charging) ICON="󰂄"; MSG="Charging" ;;
  fully-charged) ICON="󰁹"; MSG="Full" ;;
  discharging)
    MSG="Discharging"
    [ "$CAP" -ge 95 ] && ICON="󰁹" || [ "$CAP" -ge 75 ] && ICON="󰂀" || [ "$CAP" -ge 55 ] && ICON="󰁿" || [ "$CAP" -ge 35 ] && ICON="󰁽" || [ "$CAP" -ge 15 ] && ICON="󰁻" || ICON="󰎁"
    ;;
  *) ICON="󰂎"; MSG="$STAT" ;;
esac
COLOR='#c4a0f0'
[ "$STAT" = "discharging" ] && [ "$CAP" -le 20 ] && COLOR='#f38ba8'

CAP_PAD=$(printf "%3s" "${CAP}")
WATT_PAD=$(printf "%5s" "${WATTS}W")
VOLT_PAD=$(printf "%5s" "${VOLTS}V")

[ -n "$T2E" ] && TIME_STR="  ⏳ Remaining: $(printf "%-12s" "${T2E}")" || TIME_STR=""
[ -n "$T2F" ] && [ "$CAP" -lt 99 ] && TIME_STR="  ⏳ Until Full: $(printf "%-11s" "${T2F}")" || TIME_STR=""

read -r -d '' TT <<EOF
<span size='xx-large' color='${COLOR}'>${ICON} <b>${CAP}%</b></span>  <span size='large' color='${C_TEXT}'><b>${MSG}</b></span>
<span color='${C_MUTED}'>${MODEL:-Unknown Battery}${TIME_STR}</span>

<span color='${C_ACCENT}'><b>STATUS</b></span>
<span color='${C_TEXT}' font_family='monospace'>  🔋 Level    : ${CAP_PAD}%         ⚡ Rate: ${WATT_PAD}
  🔌 Voltage  : ${VOLT_PAD}</span>

<span color='${C_ACCENT}'><b>HEALTH</b></span>
<span color='${C_TEXT}' font_family='monospace'>  ❤️ Capacity : $(printf "%-5s" "${HEALTH:-?}%")     ⚡ Energy: ${ENERGY:-?}/${E_FULL:-?} Wh
  📊 Design   : ${E_DESIGN:-N/A} Wh</span>
EOF

jq -n -c --arg text "<span color='${COLOR}'>${ICON}</span>  <span color='${C_TEXT}'>${CAP}%</span>" --arg tooltip "$TT" '{text: $text, tooltip: $tooltip}'
