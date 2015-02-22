#! /bin/sh

while :
do
	TOUCH_ID=$(xinput list | grep TouchPad | grep -P 'id=(\d+)' -o | grep -P '\d+' -o)
	mouse=$(xinput list | grep Mouse)
	if [ -n "$mouse" ] #if there is mouse
	then
		xinput set-prop $TOUCH_ID "Device Enabled" 0 # disable touchpad
	else
		xinput set-prop $TOUCH_ID "Device Enabled" 1 # enable touchpad
	fi
	sleep 5
done
