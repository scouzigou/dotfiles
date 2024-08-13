#!/usr/bin/env bash

dir="~/.config/polybar/rofi"
uptime=$(uptime -p | sed -e 's/up //g')

rofi_command="rofi -no-config -kb-row-up k -kb-row-down j -theme $dir/powermenu"

lock="󰌾  Lock"
shutdown="󰐥  Shutdown"
reboot="󰜉  Restart"
suspend="󰒲  Sleep"
logout="󰍃  Logout"

options="$lock\n$suspend\n$logout\n$reboot\n$shutdown\n"

chosen="$(echo -e "$options" | $rofi_command -p "Uptime: $uptime" -dmenu -selected-row 0)"
case $chosen in
$shutdown)
  systemctl poweroff
  ;;
$reboot)
  systemctl reboot
  ;;
$lock)
  loginctl lock-session
  ;;
$suspend)
  systemctl suspend
  ;;
$logout)
  i3-msg exit
  ;;
esac
