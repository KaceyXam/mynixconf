#!/usr/bin/env bash

windows=$(niri msg -j windows)

selected=$(
  echo "$windows" |
    jq -r '.[] | "\(.id)\t\(.app_id)\t\(.title // "")"' |
    fuzzel --dmenu --index
)

[ -z "$selected" ] && exit 0

id=$(printf '%s' "$selected" | cut -f1)

niri msg action focus-window --id "$id"
