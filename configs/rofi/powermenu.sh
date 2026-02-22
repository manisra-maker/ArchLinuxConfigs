#!/bin/bash

# Define options
options="  Shutdown\n  Reboot\n  Suspend\n  Hibernate\n  Lock\n  Cancel"

# Show Rofi menu
chosen=$(echo -e "$options" | rofi -dmenu -i -p "Power Menu" -theme-str 'window {width: 300px;}')

# Trim leading spaces (if any)
chosen=$(echo "$chosen" | sed 's/^ *//')

# Perform the selected action
case "$chosen" in
    "  Shutdown") 
        if command -v systemctl &> /dev/null; then
            systemctl poweroff
        else
            sudo /sbin/shutdown -h now
        fi
        ;;
    "  Reboot") 
        if command -v systemctl &> /dev/null; then
            systemctl reboot
        else
            sudo /sbin/shutdown -r now
        fi
        ;;
    "  Suspend") systemctl suspend ;;
    "  Hibernate") systemctl hibernate ;;
    "  Lock") hyprlock ;;  # Change to your lock command if different
    "  Cancel") exit 0 ;;
    *) exit 1 ;;
esac
