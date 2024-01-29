#!/bin/bash

cpu_idle=$(mpstat 1 1 | grep "Average" | awk '{print $NF}')
cpu_usage=$(echo "100-$cpu_idle" | bc)
temp=$(( $(cat /sys/class/hwmon/hwmon1/temp1_input) / 1000 ))
fan_speed=$(cat /sys/class/hwmon/hwmon6/fan1_input)

echo "{\"text\": \"CPU: ${cpu_usage}% / ${temp}°C / ${fan_speed} RPM\"}"
