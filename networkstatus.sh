#wifi icons
ICON_WIFI_DISCONNECTED='睊'
ICON_WIFI_CONNECTED='直'

#ethernet icons
ICON_ETHERNET_DISCONNECTED=''
ICON_ETHERNET_CONNECTED=''

wifi() {
	local IFACE=`cat ./wifi`
	STATEFILE='/sys/class/net/'$IFACE'/operstate'

	case `cat $STATEFILE` in
		up)	echo "%{F#11FF11}"$ICON_WIFI_CONNECTED": "`ip -4 addr show $IFACE | grep -oP '(?<=inet\s)\d+(\.\d+){3}'`' ('`iwgetid --raw`')' ;;
		down) echo "%{F#FF1111}"$ICON_WIFI_DISCONNECTED": DOWN" ;;
	esac
}

ethernet() {
	local IFACE=`cat ./ethernet`
	STATEFILE='/sys/class/net/'$IFACE'/operstate'

	case `cat $STATEFILE` in
		up)	echo "%{F#11FF11}"$ICON_ETHERNET_CONNECTED": "`ip -4 addr show $IFACE | grep -oP '(?<=inet\s)\d+(\.\d+){3}'` ;;
		down) echo "%{F#FF1111}"$ICON_ETHERNET_DISCONNECTED": DOWN" ;;
	esac
}

case $1 in
	eth) ethernet ;;
	wifi) wifi ;;
	*) echo "USAGE: ./ethstatus.sh (eth|wifi)" ;;
esac

#from polybar config
#label-disconnected-foreground = #FF1111
#label-disconnected = : DOWN
#label-connected-foreground = #11FF11
#label-connected = : %local_ip%
#
#label-disconnected-foreground = #FF1111
#label-disconnected = 
#label-connected-foreground = #11FF11
#label-connected = : %local_ip% (%essid%)
