#!/bin/bash

# We use 'printf' to ensure the newline is passed correctly to Sketchybar
# This creates a string with a literal newline character
STACKED_DATE=$(date "+%a %d %b")

sketchybar --set $NAME \
  icon="$STACKED_DATE" \
  icon.font="Hack Nerd Font:Regular:10.0" \
  label="$(date '+%H:%M')" \
  label.font="Hack Nerd Font:Bold:12.0" \
  background.color=0xF5C85700 \
  background.corner_radius=16 \
