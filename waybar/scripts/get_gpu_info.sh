#!/bin/bash

temp=$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits)
usage=$(nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits)
fan_speed=$(cat /sys/class/hwmon/hwmon6/fan2_input)
echo "{\"text\": \"GPU: ${usage}% / ${temp}°C / ${fan_speed} RPM\"}"
