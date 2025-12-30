#!/bin/bash

# Get total memory
TOTAL_MEM=$(sysctl -n hw.memsize)
TOTAL_GB=$(awk "BEGIN {printf \"%.0f\", $TOTAL_MEM / 1024 / 1024 / 1024}")

# Get memory usage and page size
VM_STAT=$(vm_stat)
PAGE_SIZE=$(echo "$VM_STAT" | head -1 | grep -o '[0-9]*' | tail -1)

ACTIVE=$(echo "$VM_STAT" | grep 'Pages active' | grep -o '[0-9]*')
WIRED=$(echo "$VM_STAT" | grep 'Pages wired down' | grep -o '[0-9]*')
COMPRESSED=$(echo "$VM_STAT" | grep 'Pages occupied by compressor' | grep -o '[0-9]*')

# Calculate used memory
USED_GB=$(awk "BEGIN {printf \"%.1f\", ($ACTIVE + $WIRED + $COMPRESSED) * $PAGE_SIZE / 1024 / 1024 / 1024}")
PERCENTAGE=$(awk "BEGIN {printf \"%.0f\", ($USED_GB / $TOTAL_GB) * 100}")

# Set color based on percentage
if [ "$PERCENTAGE" -gt 80 ]; then
  COLOR=0xffff5555  # red
elif [ "$PERCENTAGE" -gt 60 ]; then
  COLOR=0xffffb86c  # orange
else
  COLOR=0xfff8f8f2  # white
fi

sketchybar --set $NAME \
  icon= \
  label="RAM ${PERCENTAGE}%" \
  label.font="Hack Nerd Font:Bold:10.0" \
  icon.color=$COLOR \
  label.color=$COLOR
