# /bin/bash

# kill existing
killall -q polybar

# wait for polybar to die
while pgrep -x polybar >/dev/null; do sleep 1; done

# start our config
polybar --config=~/.config/polybar/base.conf -r top &
polybar --config=~/.config/polybar/base.conf -r bottom 