#!/usr/bin/env bash

lock="  Lock"
logout="󰍃  Logout"
suspend="󰒲  Suspend"
shutdown="  Shutdown"
reboot="  Reboot"

choice=$(
  printf "%s\n%s\n%s\n%s\n%s\n" \
    "$lock" "$logout" "$suspend" "$reboot" "$shutdown" |
  rofi -dmenu -theme $HOME/.config/rofi/config-powermenu.rasi
  )

[ -z "$choice" ] && exit 0

sleep 0.2

case "$choice" in
  "$lock")
    loginctl lock-session
    ;;
  "$logout")
    loginctl terminate-user "$USER"
    ;;
  "$suspend")
    systemctl suspend
    ;;
  "$shutdown")
    systemctl poweroff
    ;;
  "$reboot")
    systemctl reboot
    ;;
esac
