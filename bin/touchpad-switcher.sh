#!/bin/sh

touchpad_id=$(xinput | grep -i "touchpad" | cut -f2 | cut -d '=' -f2);


if xinput | grep -i "mouse" | grep -i "pointer"

    then xinput set-prop $touchpad_id "Device Enabled" 0 |
         notify-send "Disabling the touchpad..." ""

    else xinput set-prop $touchpad_id "Device Enabled" 1 |
         notify-send "The touchpad is now enabled." ""

fi

