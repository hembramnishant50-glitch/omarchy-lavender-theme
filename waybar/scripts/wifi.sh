#!/bin/bash

C_ACCENT="#c4a0f0"
C_MUTED="#8c92a3"
C_TEXT="#dcd6d6"
C_GREEN="#a6e3a1"
C_RED="#f38ba8"

IFACE=$(ip route | grep default | awk '{print $5}' | head -n 1)
[ -z "$IFACE" ] && jq -n -c --arg text "<span color='#f38ba8'>󰤮</span>" --arg tooltip "Offline" '{text: $text, tooltip: $tooltip}' && exit 0

LINK=$(iw dev "$IFACE" link 2>/dev/null)
SSID=$(echo "$LINK" | grep "SSID:" | sed 's/.*SSID: //')

if [ -n "$SSID" ]; then
  IS_WIFI=true
  DB=$(echo "$LINK" | grep "signal:" | awk '{print $2}' | tr -d '-')
  [ -z "$DB" ] && DB=0
  SIG=$(( 2 * (100 - DB) ))
  [ "$SIG" -gt 100 ] && SIG=100
  [ "$SIG" -lt 0 ] && SIG=0
  SEC=$(nmcli -t -f SSID,SECURITY device wifi list 2>/dev/null | grep "^${SSID}:" | cut -d: -f2 | head -1)
  [ -z "$SEC" ] && SEC="WPA2"
else
  IS_WIFI=false
  SSID="ETHERNET"
  SIG=100
  SEC=""
fi

LOCAL=$(ip addr show "$IFACE" 2>/dev/null | grep -Po 'inet \K[\d.]+' | head -n 1)
GATEWAY=$(ip route | grep default | awk '{print $3}' | head -n 1)
PUBLIC=$(curl -s --connect-timeout 2 https://ifconfig.me || echo "N/A")
DNS=$(nmcli -t -f IP4.DNS dev show "$IFACE" 2>/dev/null | head -3 | paste -sd ", " -)
SPEED=$(cat "/sys/class/net/$IFACE/speed" 2>/dev/null || echo "?")
MAC=$(cat "/sys/class/net/$IFACE/address" 2>/dev/null)

# --- Location info (cached) ---
CACHE="/tmp/wifi_location.cache"
if [ -f "$CACHE" ] && [ "$(($(date +%s) - $(stat -c %Y "$CACHE")))" -lt 3600 ]; then
  LOCATION=$(cat "$CACHE")
else
  LOCATION=$(curl -s --connect-timeout 3 https://ipinfo.io/json 2>/dev/null)
  [ -n "$LOCATION" ] && echo "$LOCATION" > "$CACHE"
fi

if command -v jq &>/dev/null; then
  LOC_CITY=$(echo "$LOCATION" | jq -r '.city // ""' 2>/dev/null)
  LOC_REGION=$(echo "$LOCATION" | jq -r '.region // ""' 2>/dev/null)
  LOC_COUNTRY=$(echo "$LOCATION" | jq -r '.country // ""' 2>/dev/null)
  LOC_ORG=$(echo "$LOCATION" | jq -r '.org // ""' 2>/dev/null)
fi

# --- Generic VPN detection ---
VPN_IFACE=""
VPN_TYPE=""
VPN_LOCAL=""

# Check WireGuard
for f in /etc/wireguard/*.conf; do
  [ -f "$f" ] || continue
  iface=$(basename "$f" .conf)
  if ip link show "$iface" 2>/dev/null | grep -q "UP"; then
    VPN_IFACE="$iface"
    VPN_TYPE="WireGuard"
    VPN_LOCAL=$(ip addr show "$iface" 2>/dev/null | grep -Po 'inet \K[\d.]+' | head -1)
    break
  fi
done

# Check OpenVPN / tun interfaces (only if no WG found)
if [ -z "$VPN_IFACE" ]; then
  for iface in /sys/class/net/*/; do
    name=$(basename "$iface")
    [ "$name" = "lo" ] && continue
    [ "$IFACE" = "$name" ] && continue
    if ip link show "$name" 2>/dev/null | grep -q "UP"; then
      if [[ "$name" == tun* ]] || [[ "$name" == tap* ]]; then
        VPN_IFACE="$name"
        VPN_LOCAL=$(ip addr show "$name" 2>/dev/null | grep -Po 'inet \K[\d.]+' | head -1)
        if pgrep -x openvpn >/dev/null 2>&1; then
          VPN_TYPE="OpenVPN"
        else
          VPN_TYPE="VPN"
        fi
        break
      fi
    fi
  done
fi

# Check openvpn process without tun interface
if [ -z "$VPN_IFACE" ] && pgrep -x openvpn >/dev/null 2>&1; then
  VPN_TYPE="OpenVPN"
  VPN_IFACE="openvpn"
fi

# --- Build location string ---
LOC_STR=""
[ -n "$LOC_CITY" ] && LOC_STR="${LOC_CITY}"
[ -n "$LOC_REGION" ] && LOC_STR="${LOC_STR:+${LOC_STR}, }${LOC_REGION}"
[ -n "$LOC_COUNTRY" ] && LOC_STR="${LOC_STR:+${LOC_STR}, }${LOC_COUNTRY}"
[ -z "$LOC_STR" ] && LOC_STR="N/A"

ORG_STR="${LOC_ORG:-N/A}"
ORG_SHORT=$(echo "$ORG_STR" | sed 's/^AS[0-9]* //')

# --- VPN tooltip line ---
if [ -n "$VPN_IFACE" ]; then
  VPN_LABEL="${VPN_TYPE:-VPN}"
  VPN_TOOLTIP="  <span color='${C_GREEN}'><b>${VPN_LABEL}</b></span>  <span>${VPN_LOCAL:-N/A}</span>"
else
  VPN_TOOLTIP="  <span color='${C_MUTED}'><b>VPN Off</b></span>"
fi

# --- Wi-Fi icon ---
if $IS_WIFI; then
  if [ "$SIG" -ge 80 ]; then WIFI_ICON="󰤨"
  elif [ "$SIG" -ge 60 ]; then WIFI_ICON="󰤥"
  elif [ "$SIG" -ge 40 ]; then WIFI_ICON="󰤢"
  else WIFI_ICON="󰤟"; fi
else
  WIFI_ICON="󰈀"
fi

# --- Pick icon: tunnel when VPN connected ---
if [ -n "$VPN_IFACE" ] && $IS_WIFI; then
  BAR_ICON="󱛋"
else
  BAR_ICON="$WIFI_ICON"
fi

SIG_PAD=$(printf "%3s" "${SIG}")
SPD_PAD=$(printf "%5s" "${SPEED}Mb/s")

read -r -d '' TT <<EOF
<span size='xx-large' color='${C_ACCENT}'>${WIFI_ICON} <b>${SSID}</b></span>
<span color='${C_MUTED}'>${IFACE}  •  Signal ${SIG}%  •  ${SPEED}Mb/s</span>

<span color='${C_ACCENT}'><b>NETWORK</b></span>
<span color='${C_TEXT}' font_family='monospace'>  📶 Signal  : ${SIG_PAD}%      🔒 Security: $(printf "%-12s" "${SEC:-N/A}")
  ⚡ Speed   : ${SPD_PAD}      📡 Iface  : ${IFACE}
  🔗 MAC     : ${MAC:-N/A}</span>

<span color='${C_ACCENT}'><b>ADDRESSES</b></span>
<span color='${C_TEXT}' font_family='monospace'>  🏠 Local  : ${LOCAL}
  🌐 Public : ${PUBLIC}
  🚪 Gateway: ${GATEWAY}
  📖 DNS    : ${DNS:-N/A}</span>

<span color='${C_ACCENT}'><b>LOCATION</b></span>
<span color='${C_TEXT}' font_family='monospace'>  📍 ${LOC_STR}
  🏢 ${ORG_SHORT}</span>

<span color='${C_ACCENT}'><b>VPN</b></span>
<span color='${C_TEXT}' font_family='monospace'>${VPN_TOOLTIP}</span>
EOF

jq -n -c --arg text "<span color='${C_ACCENT}'>${BAR_ICON}</span>  <span color='${C_TEXT}'>${SIG}%</span>" --arg tooltip "$TT" '{text: $text, tooltip: $tooltip}'
