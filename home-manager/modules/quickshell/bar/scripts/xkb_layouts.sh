#!/usr/bin/env bash

set -euo pipefail

for rules_file in \
  /etc/X11/layouts.lst \
  /run/current-system/sw/share/X11/xkb/rules/base.lst \
  /usr/share/X11/xkb/rules/base.lst; do
  if [[ -r "$rules_file" ]]; then
    exec cat "$rules_file"
  fi
done

exit 1
