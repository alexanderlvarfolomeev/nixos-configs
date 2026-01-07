wlan=$1
if [[ -z "$wlan" ]]; then
  echo "NO WLAN"
  exit 1
fi
iwctl station $wlan show | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2};?)?)?[mGK]//g"