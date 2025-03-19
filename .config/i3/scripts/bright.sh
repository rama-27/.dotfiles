#!/bin/bash

# Get current brightness and max
CURRENT=$(brightnessctl get)
MAX=$(brightnessctl max)
STEP=$((MAX / 20))  # 5% of max (e.g., 12-13 if max is 255)

# Up or down based on argument
case "$1" in
    "up")
        NEW=$((CURRENT + STEP))
        if [ $NEW -gt $MAX ]; then NEW=$MAX; fi
        brightnessctl set "$NEW"
        ;;
    "down")
        NEW=$((CURRENT - STEP))
        if [ $NEW -lt 0 ]; then NEW=0; fi
        brightnessctl set "$NEW"
        ;;
    *)
        echo "Usage: $0 {up|down}"
        exit 1
        ;;
esac

# Optional: Notify (uncomment if you use notify-send)
# notify-send "Brightness: $((NEW * 100 / MAX))%"
