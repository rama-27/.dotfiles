#!/bin/bash

temp=$(sensors k10temp-pci-00c3 | grep "Tctl:" | awk '{print $2}' | sed 's/+//g' | sed 's/\.0°C//g')

if [ -n "$temp" ]; then
  echo "{\"full_text\": \"Temp: $temp°C\"}"
else
  echo "{\"full_text\": \"Temp: N/A\"}"
fi
