#!/bin/bash

C_ACCENT="#c4a0f0"
C_MUTED="#8c92a3"
C_TEXT="#dcd6d6"

BAT_PATH=""
if command -v upower &>/dev/null; then
  BAT_PATH=$(upower -e 2>/dev/null | grep -i bat | head -1)
elif [ -d /sys/class/power_supply ]; then
  for dir in /sys/class/power_supply/*/; do
    [ -f "${dir}type" ] && [ "$(cat "${dir}type" 2>/dev/null)" = "Battery" ] && BAT_PATH="$dir" && break
  done
fi

[ -z "$BAT_PATH" ] && echo "" && exit 0

if command -v upower &>/dev/null; then
  DATA=$(upower -i "$BAT_PATH" 2>/dev/null)
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
elif [ -n "$BAT_PATH" ]; then
  CAP=$(cat "${BAT_PATH}capacity" 2>/dev/null)
  STAT=$(cat "${BAT_PATH}status" 2>/dev/null)
  MODEL=$(cat "${BAT_PATH}manufacturer" 2>/dev/null || cat "${BAT_PATH}model_name" 2>/dev/null)
  ENERGY=$(cat "${BAT_PATH}energy_now" 2>/dev/null)
  E_FULL=$(cat "${BAT_PATH}energy_full" 2>/dev/null)
  E_DESIGN=$(cat "${BAT_PATH}energy_full_design" 2>/dev/null)
  POWER=$(cat "${BAT_PATH}power_now" 2>/dev/null)
  VOLTS=$(cat "${BAT_PATH}voltage_now" 2>/dev/null)
  [ -n "$POWER" ] && WATTS=$(echo "scale=2; $POWER / 1000000" | bc -l 2>/dev/null)
  [ -n "$VOLTS" ] && VOLTS=$(echo "scale=2; $VOLTS / 1000000" | bc -l 2>/dev/null)
  [ -n "$CAP" ] && CAP=$((CAP))
  case "$STAT" in
    Charging) T2F="..." ;;
    Discharging) T2E="..." ;;
  esac
fi

[ -z "$CAP" ] && CAP=0
[ -n "$E_FULL" ] && [ -n "$E_DESIGN" ] && [ "$E_DESIGN" != "0" ] && HEALTH=$(echo "scale=1; $E_FULL / $E_DESIGN * 100" | bc -l 2>/dev/null | sed 's/\.0$//') || HEALTH=""

IDX=$(( CAP < 100 ? CAP / 10 : 9 ))
CHARGING_ICONS=("󰢜" "󰂆" "󰂇" "󰂈" "󰢝" "󰂉" "󰢞" "󰂊" "󰂋" "󰂅")

case "$STAT" in
  charging)
    ICON="${CHARGING_ICONS[$IDX]}"
    MSG="Charging"
    ;;
  fully-charged)
    ICON="${CHARGING_ICONS[$IDX]}"
    MSG="Full"
    ;;
  discharging)
    DEFAULT_ICONS=("󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹")
    ICON="${DEFAULT_ICONS[$IDX]}"
    MSG="Discharging"
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
