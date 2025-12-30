#!/bin/bash

# Get disk usage for root filesystem
DISK_USAGE=$(df -h / | awk 'NR==2 {print $5}' | tr -d '%')

# Set color based on usage
if [ "$DISK_USAGE" -gt 90 ]; then
  COLOR=0xffff5555  # red
elif [ "$DISK_USAGE" -gt 70 ]; then
  COLOR=0xffffb86c  # orange
else
  COLOR=0xfff8f8f2  # white
fi

sketchybar --set $NAME \
  icon=󰋊 \
  label="${DISK_USAGE}%" \
  icon.color=$COLOR \
  label.color=$COLOR
