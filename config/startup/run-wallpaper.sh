#!/bin/bash

# Check if another instance of script is running
EXISTING_PROCESS=$(pidof -o %PPID -x $0)
if(($EXISTING_PROCESS))
	then
		echo "ERROR: Script \"$0\" already running in PID $EXISTING_PROCESS" && exit 1
	fi

SHOULD_STOP=0
trap 'SHOULD_STOP=1' SIGABRT
#trap 'SHOULD_STOP=2' SIGIOT
trap 'SHOULD_STOP=3' SIGFPE
trap 'SHOULD_STOP=4' SIGHUP
trap 'SHOULD_STOP=5' SIGILL
trap 'SHOULD_STOP=6' SIGINT
trap 'SHOULD_STOP=7' SIGKILL
trap 'SHOULD_STOP=8' SIGQUIT
trap 'SHOULD_STOP=9' SIGTERM

COLOR_HEX="$(cat /sys/class/leds/system76_acpi::kbd_backlight/color)"

ARGB="#$COLOR_HEX"

while (($SHOULD_STOP == 0))
do
	COLOR_HEX="$(cat /sys/class/leds/system76_acpi::kbd_backlight/color)"
	ARGB_TEMP="#$COLOR_HEX"

	if [ $ARGB = $ARGB_TEMP ]
	then
		sleep 0.1
	else
		xsetroot -solid $ARGB_TEMP > /dev/null
		ARGB="$ARGB_TEMP"
	fi
done

exit $SHOULD_STOP