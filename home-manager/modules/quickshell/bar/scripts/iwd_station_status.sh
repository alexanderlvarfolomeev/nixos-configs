#!/usr/bin/env bash

set -euo pipefail

wlan="${1:-}"

if [[ -z "$wlan" ]]; then
  for wireless_path in /sys/class/net/*/wireless; do
    [[ -d "$wireless_path" ]] || continue
    wlan="$(basename "$(dirname "$wireless_path")")"
    break
  done
fi

if [[ -z "$wlan" ]]; then
  exit 2
fi

LC_ALL=C iwctl station "$wlan" show \
  | sed -E $'s/\033\\[[0-9;]*[[:alpha:]]//g'
