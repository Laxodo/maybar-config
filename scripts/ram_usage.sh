#!/bin/bash
USED=$(free -h | awk '/Mem:/ {print $3}')
TOTAL=$(free -h | awk '/Mem:/ {print $2}')
echo "🧠 $USED / $TOTAL"

