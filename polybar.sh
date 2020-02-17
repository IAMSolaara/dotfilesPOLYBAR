#!/bin/bash

#terminate any polybar instance
killall -q polybar

#wait for all polybar processes to be down
while pgrep -u $UID -x polybar > /dev/null; do sleep 1; done

#have default network interface(s) available as variable
export DEFAULT_ETHERNET=$(ip route | grep '^default' | awk '{print $5}' | grep e)
export DEFAULT_WIFI=$(ip route | grep '^default' | awk '{print $5}' | grep w)

#excluding this until there is a way to exclude mounts in polybar
#MCONT=0
#
#for x in `df | awk '/^\/dev\//{print $6}' | grep -v 'boot'`; do
#	CURMOUNT="POLYBAR_MOUNT"$MCONT
#	export $CURMOUNT=$x
#	let "MCONT+=1"
#done

#launch polybar with default config
polybar top &
polybar bottom &

echo "polybar running..."
