#!/bin/bash

gammastep_config_file="$HOME/.config/gammastep/config.ini"

get_brightness(){
	brightness=$(awk -F'=' '/^brightness/{print $2}' "$gammastep_config_file")
    echo "{\"text\": \"Brightness: $brightness\"}"
}

get_brightness

while true ; do
	inotifywait -e modify "$gammastep_config_file"
	get_brightness
done
