#!/bin/bash

gammastep_config_file="$HOME/.config/gammastep/config.ini"

get_temp(){
	temp_day=$(awk -F'=' '/^temp-day/{print $2}' "$gammastep_config_file")
    echo "{\"text\": \"Temp: $temp_day K\"}"
}

get_temp

while true ; do
	inotifywait -e modify "$gammastep_config_file"
	get_temp
done
