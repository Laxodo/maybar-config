#!/bin/bash
CPU=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')
printf "🖥️ %.0f%%" "$CPU"

