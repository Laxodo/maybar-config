#!/bin/bash
if command -v nvidia-smi &> /dev/null; then
    USAGE=$(nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits | head -n 1)
    echo "🎮 ${USAGE}%"
else
    echo "NVIDIA N/A"
fi

