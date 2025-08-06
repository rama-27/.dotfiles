#!/bin/bash

# Get free space for the root partition (or change to another mount point, e.g., /home)
FREE_SPACE=$(df -h / | tail -1 | awk '{print $4}')

# Output in JSON format for Waybar
echo "{\"text\": \"$FREE_SPACE\", \"tooltip\": \"Free disk space: $FREE_SPACE\", \"class\": \"storage\"}"
