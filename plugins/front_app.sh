#!/bin/bash

if [ "$SENDER" = "front_app_switched" ]; then
  # Map app names to icons
  case "$INFO" in
    "Arc")
      ICON="🌐"  # Placeholder icon for Arc
      ;;
    "Code" | "Visual Studio Code")
      ICON="💻"  # Placeholder icon for Code
      ;;
    "Ghostty")
      ICON="👻"  # Placeholder icon for Ghostty
      ;;
    *)
      ICON="📱"  # Default icon for other apps
      ;;
  esac

  # Set the app name and icon
  sketchybar --set $NAME label="$INFO" icon="$ICON"
fi
