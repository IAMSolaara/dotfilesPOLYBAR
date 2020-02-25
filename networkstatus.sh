#!/bin/sh

#get script directory
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

#wifi icons
ICON_WIFI_DISCONNECTED='睊'
ICON_WIFI_CONNECTED='直'

#ethernet icons
ICON_ETHERNET_DISCONNECTED=''
ICON_ETHERNET_CONNECTED=''

wifi() {
	if [[ ! -f $DIR/wifi.dis ]]; then
		if [[ -f $DIR/wifi ]]; then
			local IFACE=`cat $DIR/wifi`
			STATEFILE='/sys/class/net/'$IFACE'/operstate'

			case `cat $STATEFILE` in
				up)	echo "%{F#11FF11}"$ICON_WIFI_CONNECTED": "`ip -4 addr show $IFACE | grep -oP '(?<=inet\s)\d+(\.\d+){3}'`' ('`iwgetid --raw`')' ;;
				down) echo "%{F#FF1111}"$ICON_WIFI_DISCONNECTED": DOWN" ;;
			esac
		else
			echo "";
		fi
	else
		echo "";
	fi
}

ethernet() {
	if [[ ! -f $DIR/ethernet.dis ]]; then
		if [[ -f $DIR/ethernet ]]; then
			local IFACE=`cat $DIR/ethernet`
			STATEFILE='/sys/class/net/'$IFACE'/operstate'

			case `cat $STATEFILE` in
				up)	echo "%{F#11FF11}"$ICON_ETHERNET_CONNECTED": "`ip -4 addr show $IFACE | grep -oP '(?<=inet\s)\d+(\.\d+){3}'` ;;
				down) echo "%{F#FF1111}"$ICON_ETHERNET_DISCONNECTED": DOWN" ;;
			esac
		else
			echo "";
		fi
	else
		echo "";
	fi
}

case $1 in
	eth) ethernet ;;
	wifi) wifi ;;
	*) echo "USAGE: ./ethstatus.sh (eth|wifi)" ;;
esac

#from polybar config
#label-disconnected-foreground = #FF1111
#label-disconnected = : DOWN
#label-connected-foreground = #11FF11
#label-connected = : %local_ip%

#label-disconnected-foreground = #FF1111
#label-disconnected = 睊
#label-connected-foreground = #11FF11
#label-connected = 直: %local_ip% (%essid%)
