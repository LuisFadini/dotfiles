#!/usr/bin/env bash

options=(
  "  Lock"
  "󰍃  Logout"
  "󰒲  Suspend"
  "  Shutdown"
  "  Reboot"
)

choice=$(printf '%s\n' "${options[@]}" | wofi \
  -dmenu \
  -p "Power" \
  -j \
  -m)

case "$choice" in
  *Lock*)
    loginctl lock-session
    ;;
  *Logout*)
    loginctl terminate-user "$USER"
    ;;
  *Suspend*)
    systemctl suspend
    ;;
  *Shutdown*)
    systemctl poweroff
    ;;
  *Reboot*)
    systemctl reboot
    ;;
esac
