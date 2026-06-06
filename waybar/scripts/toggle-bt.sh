#!/bin/bash

STATE=$(busctl get-property org.bluez /org/bluez/hci0 org.bluez.Adapter1 Powered)

if [[ "$STATE" == *"true"* ]]; then
    busctl set-property org.bluez /org/bluez/hci0 org.bluez.Adapter1 Powered b false
else
    busctl set-property org.bluez /org/bluez/hci0 org.bluez.Adapter1 Powered b true
fi
