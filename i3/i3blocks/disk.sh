#!/bin/bash
COLOR="#c037c4"
DF_RES=$(df -ha /dev/sda3)
if [ "$?" -ne 0 ]
then
    exit 0
fi

REGEX=".* (.+) (100|[0-9]{2}%).*"
TEXT=""

if [[ "$DF_RES" =~ $REGEX ]]
then
    TEXT="$TEXT<span size=\"x-large\" foreground=\"$COLOR\"><s></s></span> "
    TEXT="${TEXT}${BASH_REMATCH[1]}"
    TEXT="$TEXT<span size=\"x-large\" foreground=\"$COLOR\"><s></s></span> "
    TEXT="${TEXT}${BASH_REMATCH[2]}"
fi

echo -e "${TEXT}"
