#!/bin/bash

devices=$(pw-dump | jq -r '
  .[] 
  | select(.type == "PipeWire:Interface:Node") 
  | select(.info.props."media.class" == "Audio/Sink") 
  | "\(.id):\(.info.props."node.description")"
')

if [[ -z "$devices" ]]; then
  notify-send "No se encontraron salidas de audio"
  exit 1
fi

options=$(echo "$devices" | cut -d: -f2-)

chosen=$(echo "$options" | wofi --dmenu --prompt "Selecciona salida de audio:")

if [[ -n "$chosen" ]]; then
  device_id=$(echo "$devices" | grep ":$chosen" | cut -d: -f1)

  wpctl set-default "$device_id"

  notify-send "Salida de audio cambiada a:" "$chosen"
fi

