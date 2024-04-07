#!/bin/bash

Time(){
	TIME=$(date "+%a %d %H:%M")
	echo -n "$TIME"
}

Light(){
	L=$(light)
	LIGHTINFO=${L%.*?}
	LIGHTICON="󰃟"
	echo -n "$LIGHTICON  $LIGHTINFO"
}

Cpu(){
	CPUINFO=$(ps -A -o pcpu | tail -n+2 | paste -sd+ | bc)
	CPUICON=""
	echo -n "$CPUICON  $CPUINFO"
}
Mem(){
	MEMINFO=$(free -h | awk 'FNR == 2 {print $4}' | tr -d i)
	MEMICON=""
	echo -n "$MEMICON  $MEMINFO"
}

Disk(){
	DISKINFO=$(df -h | awk 'FNR == 4 {print $5}')
	DISKICON=""
	echo -n "$DISKICON  $DISKINFO"
}

Lan(){
	LANINFO=$(iwgetid -r)
	if [ $(nmcli r wifi) == enabled ] && [ -z "$LANINFO" ]
		then
			LANICON=""
			LANINFO="-"
	elif [ $(nmcli r wifi) == disabled ]
		then
			LANICON=""
			LANINFO="-"
	else    
		LANICON=""
	fi
	echo -n "$LANICON  $LANINFO"
}

Temp(){
	TEMPINFO=$(sensors | awk 'FNR == 7 {print $4}' | tr -d +C)
	TEMPNUM=${TEMPINFO::-3}

	if (($TEMPNUM <= 40))
		then
			TEMPICON=""
	elif ((40 < $TEMPNUM && $TEMPNUM <= 50))
		then
			TEMPICON=""
	elif ((50 < $TEMPNUM && $TEMPNUM <= 60))
		then
			TEMPICON=""
	elif ((60 < $TEMPNUM && $TEMPNUM <= 70))
		then
			TEMPICON=""
	elif ((70 < $TEMPNUM && $TEMPNUM <= 90))
		then
			TEMPICON=""       
	elif ((90 < $TEMPNUM))
		then
			TEMPICON=""
	fi
	echo -n "$TEMPICON  $TEMPINFO"
}

Bat(){	
	
	BATINFO=$(upower -i /org/freedesktop/UPower/devices/battery_BAT1 | grep percentage | awk '{print $2}')
	BATNUM=${BATINFO::-1}

	if [[ $(upower -i /org/freedesktop/UPower/devices/battery_BAT1 | grep state | awk '{print $2}') == "charging" ]]
	then 
		BATICON=""
	else 

		if (($BATNUM <= 9))
			then
				BATICON=""   
		elif ((9 < $BATNUM && $BATNUM <= 33))
			then
				BATICON=""
		elif ((33 < $BATNUM && $BATNUM <= 66))
			then
				BATICON=""
		elif ((66 < $BATNUM && $BATNUM <= 95))
			then
				BATICON=""       
		elif ((95 < $BATNUM))
			then
				BATICON=""
		fi
	fi
	echo -n "$BATICON  $BATINFO"
}

Vol(){
	
	VOLINFO=$(pactl list sinks | awk 'FNR == 10 {print $5}')
	VOLNUM=${VOLINFO::-1}
	VOLSTATE=$(pactl list sinks | awk 'FNR == 9 {print $2}')
	YES="yes"
	NO="no"
	if [[ $VOLNUM == 0 ||  $VOLSTATE == $YES ]]
		then
			VOLICON="󰝟"
	elif ((0 < $VOLNUM && $VOLNUM <= 33))
		then
			VOLICON=""
	elif ((33 < $VOLNUM && $VOLNUM <= 66))
		then
			VOLICON=""       
	elif ((66 < $VOLNUM))
		then
			VOLICON=""
	fi
	echo -n "$VOLICON  $VOLINFO"
}

i3_Workspace(){
	
	WORKSPACE=$(i3-msg -t get_workspaces | jq '.[] | select(.focused==true).name' | cut -d"\"" -f2)
	echo -n "$WORKSPACE"
}
while true
do
	sleep 0.01
	echo -e "$(Light)   $(Vol)   $(Bat)   $(Lan)   $(Time)"
done
