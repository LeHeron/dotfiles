#!/bin/bash

ifaces=$(nmcli device status)

RESULT=""
while IFS= read -r line; do
    count=0
    IP=""
    for word in $line; do
        if [[ count -eq 0 ]] ; then
            if [[ "$word" =~ ^(eno|enp|ens|enx|eth|wlan|wlp|wlo) && ! ($line =~ .*--.*) ]] ; then
                if [[ -z $RESULT ]]; then
                    RESULT="<span foreground=\"$1\">$word</span>: "
                else
                    RESULT="$RESULT | <span foreground=\"$1\">$word</span>: "
                fi
                # Get ip from interface name
                IP="$(ip a | grep -Pazo  "(?s)wlo1:.*?inet \K(([0-9]{1,3}\.){3}[0-9]{1,3})" | tr -d '\0')"
            else
                break
            fi
        fi

        if [[ count -eq 3 ]]; then
            RESULT="$RESULT<span foreground=\"#2aa33f\">$word $IP</span>"
        fi
        ((count++))
    done
done <<< "$(tail +2 <<< "$ifaces")" # Skipping first line

echo "$RESULT"
