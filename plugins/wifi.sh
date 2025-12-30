#!/bin/bash

# Loads defined colors
source "$CONFIG_DIR/colors.sh"

# Check VPN status (set to Disconnected if piactl not available)
if [ -f /usr/local/bin/piactl ]; then
  IS_VPN=$(/usr/local/bin/piactl get connectionstate 2>/dev/null)
else
  IS_VPN="Disconnected"
fi

# Get WiFi info
CURRENT_WIFI="$(ipconfig getsummary en0 2>/dev/null)"
IP_ADDRESS="$(echo "$CURRENT_WIFI" | grep -o "ciaddr = .*" | sed 's/^ciaddr = //')"
SSID="$(echo "$CURRENT_WIFI" | grep -o "SSID : .*" | sed 's/^SSID : //' | tail -n 1)"

# Set icon and color based on connection status
if [[ $IS_VPN != "Disconnected" ]]; then
  ICON_COLOR=$HIGHLIGHT
  ICON=󰖪
elif [[ $SSID = "Ebrietas" ]]; then
  ICON_COLOR=0xffffffff
  ICON=󱛂
elif [[ $SSID != "" ]]; then
  ICON_COLOR=0xffffffff
  ICON=
else
  ICON_COLOR=0x40ffffff
  ICON=
fi

render_bar_item() {
  sketchybar --set $NAME \
    icon.color=$ICON_COLOR \
    icon=$ICON
}

render_popup() {
  if [ "$SSID" != "" ]; then
    args=(
      --set wifi.ssid label="$SSID"
      --set wifi.ipaddress label="$IP_ADDRESS"
      click_script="printf $IP_ADDRESS | pbcopy;sketchybar --set wifi popup.drawing=toggle"
    )
  else
    args=(
      --set wifi.ssid label="Not connected"
      --set wifi.ipaddress label="No IP"
      )
  fi

  sketchybar "${args[@]}" >/dev/null
}

update() {
  render_bar_item
  render_popup
}

popup() {
  sketchybar --set "$NAME" popup.drawing="$1"
}

case "$SENDER" in
"routine" | "forced")
  update
  ;;
"mouse.clicked")
  popup toggle
  ;;
esac
