#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar
# If all your bars have ipc enabled, you can also use 
# polybar-msg cmd quit

if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar --reload example &
  done
else
  polybar --reload example &
fi

# Launch bar1 and bar2
echo "---" | tee -a /tmp/polybar1.log /tmp/polybar2.log
polybar white >>/tmp/polybar1.log 2>&1 &
#polybar mpd >>/tmp/polybar2.log 2>&1 &
#polybar float >>/tmp/polybar3.log 2>&1 &

echo "Bars launched..."

