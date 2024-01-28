#!/bin/bash

temp=$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits)
usage=$(nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits)
echo "{\"text\": \"GPU: ${usage}% / ${temp}°C\"}"
