#!/bin/bash

# Get memory usage and page size
VM_STAT=$(vm_stat)
PAGE_SIZE=$(echo "$VM_STAT" | head -1 | grep -o '[0-9]*' | tail -1)

ACTIVE=$(echo "$VM_STAT" | grep 'Pages active' | grep -o '[0-9]*')
WIRED=$(echo "$VM_STAT" | grep 'Pages wired down' | grep -o '[0-9]*')
COMPRESSED=$(echo "$VM_STAT" | grep 'Pages occupied by compressor' | grep -o '[0-9]*')

# Calculate used memory in GB
USED_GB=$(awk "BEGIN {printf \"%.1f\", ($ACTIVE + $WIRED + $COMPRESSED) * $PAGE_SIZE / 1024 / 1024 / 1024}")

# Set color based on usage
USED_INT=$(echo "$USED_GB" | awk '{printf "%.0f", $1}')
if [ "$USED_INT" -gt 16 ]; then
  COLOR=0xffff5555  # red
elif [ "$USED_INT" -gt 12 ]; then
  COLOR=0xffffb86c  # orange
else
  COLOR=0xfff8f8f2  # white
fi

sketchybar --set $NAME \
  icon= \
  label="${USED_GB}G" \
  icon.color=$COLOR \
  label.color=$COLOR
