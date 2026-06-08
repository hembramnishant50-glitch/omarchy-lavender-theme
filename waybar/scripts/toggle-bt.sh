#!/bin/bash

HCI_PATH=$(busctl tree org.bluez 2>/dev/null | grep -oP '/org/bluez/hci\d+' | head -1)
[ -z "$HCI_PATH" ] && HCI_PATH="/org/bluez/hci0"

if command -v busctl &>/dev/null && [ -n "$HCI_PATH" ]; then
  STATE=$(busctl get-property org.bluez "$HCI_PATH" org.bluez.Adapter1 Powered 2>/dev/null)
  if [[ "$STATE" == *"true"* ]]; then
    busctl set-property org.bluez "$HCI_PATH" org.bluez.Adapter1 Powered b false 2>/dev/null
  else
    busctl set-property org.bluez "$HCI_PATH" org.bluez.Adapter1 Powered b true 2>/dev/null
  fi
elif command -v bluetoothctl &>/dev/null; then
  echo -e "power off\nquit" | bluetoothctl 2>/dev/null
  STATE=$(echo -e "show\nquit" | bluetoothctl 2>/dev/null | grep "Powered:" | awk '{print $2}')
  [ "$STATE" = "yes" ] && echo -e "power off\nquit" | bluetoothctl 2>/dev/null || echo -e "power on\nquit" | bluetoothctl 2>/dev/null
fi
