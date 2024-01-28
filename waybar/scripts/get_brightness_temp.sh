#!/bin/bash

gammastep_config_file="$HOME/.config/gammastep/config.ini"

get_brightness_and_temp(){
	brightness=$(awk -F'=' '/^brightness/{print $2}' "$gammastep_config_file")
	temp=$(awk -F'=' '/^temp-day/{print $2}' "$gammastep_config_file")
  echo "{\"text\": \"$brightness / ${temp}K\"}"
}

get_brightness_and_temp

while true ; do
	inotifywait -e modify "$gammastep_config_file"
	get_brightness_and_temp
done
