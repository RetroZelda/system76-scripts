# /bin/bash

# kill existing
echo killing any existing processes...
killall -q -w kbd-lighterd
killall -q -w kbd-lighter

# wait for them to die
echo waiting to ensure they are dead...
while pgrep -x kbd-lighterd >/dev/null; do sleep 1; done
while pgrep -x kbd-lighter >/dev/null; do sleep 1; done

# start them up
echo starting screen for kbd-lighterd...
screen -dmS kbd-lighterd kbd-lighterd

sleep 2

echo starting screen for kbd-lighter...
screen -dmS kbd-lighter sudo kbd-lighter
sleep 1
echo done
