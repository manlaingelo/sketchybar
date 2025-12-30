#!/bin/bash

# Get CPU usage percentage
CPU_USAGE=$(ps -A -o %cpu | awk '{s+=$1} END {printf "%.0f", s}')

# Set color based on usage
if [ "$CPU_USAGE" -gt 80 ]; then
  COLOR=0xffff5555  # red
elif [ "$CPU_USAGE" -gt 50 ]; then
  COLOR=0xffffb86c  # orange
else
  COLOR=0xfff8f8f2  # white
fi

sketchybar --set $NAME \
  icon= \
  label="${CPU_USAGE}%" \
  icon.color=$COLOR \
  label.color=$COLOR
