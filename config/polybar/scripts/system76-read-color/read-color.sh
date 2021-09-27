#!/bin/bash

COLOR_HEX="$(cat /sys/class/leds/system76_acpi::kbd_backlight/color)"
BRIGHTNESS="$(cat /sys/class/leds/system76_acpi::kbd_backlight/brightness)"
BRIGHTNESS="$(printf %X $BRIGHTNESS)"
#echo "%{B#$COLOR_HEX}"
echo "$BRIGHTNESS$COLOR_HEX"