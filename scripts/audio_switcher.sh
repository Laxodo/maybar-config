#!/bin/bash

# Obtener lista de nodos tipo Audio/Sink
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

# Mostrar solo descripciones en el menú
options=$(echo "$devices" | cut -d: -f2-)

# Mostrar menú con wofi
chosen=$(echo "$options" | wofi --dmenu --prompt "Selecciona salida de audio:")

if [[ -n "$chosen" ]]; then
  # Buscar ID asociado a la opción elegida
  device_id=$(echo "$devices" | grep ":$chosen" | cut -d: -f1)

  # Establecer como dispositivo por defecto
  wpctl set-default "$device_id"

  # Notificación opcional
  notify-send "Salida de audio cambiada a:" "$chosen"
fi

